# Tạo nhạc nền ambient/tech 30s (WAV 44.1kHz stereo) khớp với các mốc chuyển cảnh của intro.html
# Chạy: python music.py  -> ../music.wav
import numpy as np, wave, os

SR = 44100
DUR = 30.0
t = np.arange(int(SR * DUR)) / SR
out = np.zeros((len(t), 2))

def note(f):  # midi -> Hz
    return 440.0 * 2 ** ((f - 69) / 12)

def env(x, a, r, length):
    e = np.clip(x / a, 0, 1) * np.clip((length - x) / r, 0, 1)
    return e

# Chord progression (Am9 - Fmaj7 - C - G - Am) đổi theo từng cảnh
chords = [
    (0.0, 5.0, [57, 60, 64, 71]),
    (4.8, 8.8, [53, 57, 60, 64]),
    (8.6, 12.5, [50, 57, 60, 65]),
    (12.3, 16.2, [48, 55, 60, 64]),
    (16.0, 19.8, [52, 55, 59, 64]),
    (19.6, 25.0, [55, 59, 62, 67]),
    (24.8, 30.0, [57, 60, 64, 69, 76]),
]
for s, e, notes in chords:
    idx = (t >= s) & (t < e)
    x = t[idx] - s
    en = env(x, 0.6, 0.8, e - s)
    for i, n in enumerate(notes):
        f = note(n)
        for det, pan in ((-0.12, 0.3), (0.12, 0.7)):  # detuned pair for width
            ff = f * 2 ** (det / 12 / 4)
            w = np.sin(2 * np.pi * ff * x) + 0.25 * np.sin(4 * np.pi * ff * x)
            out[idx, 0] += w * en * 0.035 * (1 - pan)
            out[idx, 1] += w * en * 0.035 * pan
    # bass
    b = note(notes[0] - 12)
    out[idx] += (np.sin(2 * np.pi * b * x) * en * 0.10)[:, None]

# Arpeggio pluck (16th notes at 120 BPM) from 4s
step = 0.125
for k in range(int(4.8 / step), int(29.0 / step)):
    st = k * step
    notes = [c for c in chords if c[0] <= st][-1][2]
    n = notes[[0, 2, 1, 3, 2, 1][k % 6] % len(notes)] + 12
    idx = (t >= st) & (t < st + 0.4)
    x = t[idx] - st
    w = np.sin(2 * np.pi * note(n) * x) * np.exp(-x * 14) * 0.06
    pan = 0.5 + 0.35 * np.sin(k * 0.7)
    out[idx, 0] += w * (1 - pan)
    out[idx, 1] += w * pan

# Soft kick every beat (0.5s) from 4.8s
for k in range(10, 58):
    st = k * 0.5
    idx = (t >= st) & (t < st + 0.35)
    x = t[idx] - st
    f = 50 + 90 * np.exp(-x * 30)
    ph = 2 * np.pi * np.cumsum(f) / SR
    out[idx] += (np.sin(ph) * np.exp(-x * 9) * 0.22)[:, None]

# Hi-hat (noise) off-beats
rng = np.random.default_rng(7)
for k in range(10, 58):
    st = k * 0.5 + 0.25
    idx = (t >= st) & (t < st + 0.06)
    x = t[idx] - st
    nz = rng.standard_normal(idx.sum())
    nz = np.diff(np.concatenate([[0], nz]))  # crude high-pass
    out[idx] += (nz * np.exp(-x * 60) * 0.025)[:, None]

# Impacts + reverse swell at scene transitions
for tr in (4.8, 12.3, 19.6, 24.8, 27.4):
    # riser
    idx = (t >= tr - 0.8) & (t < tr)
    x = t[idx] - (tr - 0.8)
    nz = rng.standard_normal(idx.sum()) * (x / 0.8) ** 2 * 0.05
    out[idx] += nz[:, None]
    # boom
    idx = (t >= tr) & (t < tr + 1.2)
    x = t[idx] - tr
    out[idx] += (np.sin(2 * np.pi * 45 * x) * np.exp(-x * 4) * 0.25)[:, None]

# Intro shimmer when the logo appears
idx = t < 3.5
x = t[idx]
out[idx] += (np.sin(2 * np.pi * note(81) * x) * np.exp(-x * 1.2) * np.clip(x / 0.05, 0, 1) * 0.05)[:, None]

# Simple stereo echo
d = int(0.375 * SR)
echo = np.zeros_like(out)
echo[d:, 0] = out[:-d, 1] * 0.25
echo[d:, 1] = out[:-d, 0] * 0.25
out += echo

# Master fade + normalize
out *= np.clip(t / 0.3, 0, 1)[:, None] * np.clip((DUR - t) / 1.8, 0, 1)[:, None]
out = np.tanh(out * 1.2)
out /= np.max(np.abs(out)) / 0.85

path = os.path.join(os.path.dirname(__file__), '..', 'music.wav')
with wave.open(path, 'wb') as w:
    w.setnchannels(2); w.setsampwidth(2); w.setframerate(SR)
    w.writeframes((out * 32767).astype(np.int16).tobytes())
print('Wrote', os.path.abspath(path))
