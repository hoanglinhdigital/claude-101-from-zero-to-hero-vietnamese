/* Inject extra spacing around subgraph (cluster) blocks */
const style = document.createElement('style');
style.textContent = `
  .mermaid .cluster { margin: 20px 0; }
  .mermaid .cluster rect { rx: 8; ry: 8; }
`;
document.head.appendChild(style);

mermaid.initialize({
  startOnLoad: true,
  theme: 'base',
  themeVariables: {
    primaryColor:       '#f0f4ff',
    primaryTextColor:   '#1e1b4b',
    primaryBorderColor: '#4f46e5',
    lineColor:          '#6366f1',
    fontSize:           '18px',
    lineHeight:         '1',
    nodePadding:        '6',
    fill:               '#f0f4ff',
  },
  sequence: {
    actorMargin:     20,
    boxMargin:       6,
    messageMargin:   20,
    boxTextMargin:   4,
    noteMargin:      10,
    mirrorActors:    true,
    useMaxWidth:     true,
  },
  flowchart: {
    htmlLabels:   true,
    useMaxWidth:  true,
    // padding:      20,
    // subGraphTitleMargin: { top: 5, bottom: 30 },
    clusterBkgnd: '#f0f4ff',
    clusterBorder: '#4f46e5',
    fontSize: 18,
  },
});
