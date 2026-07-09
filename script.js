// Global script cho toàn bộ chapter. Mỗi tính năng đăng ký qua registerFeature()
// và được khởi chạy tự động khi DOM sẵn sàng.
(function () {
  var features = [];

  function registerFeature(initFn) {
    features.push(initFn);
  }

  function initAll() {
    features.forEach(function (initFn) { initFn(); });
  }

  // ── Feature: Copy button cho code block ──
  (function () {
    function getCommandText(pre) {
      var codeEl = pre.querySelector('code') || pre;
      var text = codeEl.textContent;
      var outputAttr = pre.getAttribute('data-output');
      if (!outputAttr) return text;

      // Bỏ qua các dòng output (data-output="2, 5") khi copy — chỉ copy lệnh thực thi được
      var outputLines = outputAttr.split(',').map(function (n) {
        return parseInt(n.trim(), 10);
      });
      var lines = text.split('\n');
      return lines
        .filter(function (_, i) { return outputLines.indexOf(i + 1) === -1; })
        .join('\n');
    }

    function fallbackCopy(text) {
      var textarea = document.createElement('textarea');
      textarea.value = text;
      textarea.style.position = 'fixed';
      textarea.style.left = '-9999px';
      document.body.appendChild(textarea);
      textarea.select();
      document.execCommand('copy');
      document.body.removeChild(textarea);
    }

    function showCopied(btn) {
      btn.textContent = 'Copied!';
      btn.classList.add('copied');
      setTimeout(function () {
        btn.textContent = 'Copy';
        btn.classList.remove('copied');
      }, 1500);
    }

    function addCopyButton(pre) {
      if (pre.querySelector('.copy-btn')) return;

      var btn = document.createElement('button');
      btn.type = 'button';
      btn.className = 'copy-btn';
      btn.textContent = 'Copy';
      btn.setAttribute('aria-label', 'Copy code to clipboard');

      btn.addEventListener('click', function () {
        var text = getCommandText(pre);
        // navigator.clipboard đòi hỏi secure context — không khả dụng khi mở file trực tiếp bằng file://
        if (navigator.clipboard && navigator.clipboard.writeText) {
          navigator.clipboard.writeText(text).then(function () {
            showCopied(btn);
          }, function () {
            fallbackCopy(text);
            showCopied(btn);
          });
        } else {
          fallbackCopy(text);
          showCopied(btn);
        }
      });

      pre.appendChild(btn);
    }

    function initCopyButtons() {
      document.querySelectorAll('pre.code-block, pre.command-line').forEach(addCopyButton);
    }

    registerFeature(initCopyButtons);
  })();

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initAll);
  } else {
    initAll();
  }
})();
