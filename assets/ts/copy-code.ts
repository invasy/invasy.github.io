function addCopyButtons(clipboard: Clipboard) {
  document.querySelectorAll('pre > code').forEach(function (code: HTMLElement) {
    let button = document.createElement('button');
    button.classList.add('code-copy');
    button.type = 'button';
    button.title = 'Copy code';
    button.addEventListener('click', function () {
      const text: string = Array.from(code.getElementsByClassName('cl')).map((e: HTMLElement) => e.innerText).join('');
      clipboard.writeText(text).then(function () {
        button.blur();
        button.title = 'Copied'
        button.classList.add('code-copied');
        setTimeout(function () {
          button.title = 'Copy code';
          button.classList.remove('code-copied');
        }, 2000);
      }, function (error) {
        button.classList.add('code-copy-error');
      });
    });

    let codeBlock = code.parentNode;
    if (codeBlock.parentNode.classList.contains('highlight')) {
      codeBlock = codeBlock.parentNode;
    }
    const parent = codeBlock.parentNode;
    const children = parent.children;
    const index = Array.from(children).indexOf(codeBlock);
    const div = document.createElement('div');
    div.classList.add('code-block', 'chroma');
    div.append(codeBlock, button);
    parent.insertBefore(div, children[index]);
});
}

function onLoad(): void {
  if (navigator && navigator.clipboard) {
    addCopyButtons(navigator.clipboard);
  } else {
    let script = document.createElement('script');
    script.src = 'https://cdnjs.cloudflare.com/ajax/libs/clipboard-polyfill/4.0.0/es6/clipboard-polyfill.es6.min.js';
    script.integrity = 'sha512-eqdAiq5buC4UGO1vAIBz77R3ITN65dhwyD1M/v6AHaZ+6BQiqc3qVs90gJFrdC0nFMgTQ5vcHqBRkv/RjyRG7w==';
    script.crossOrigin = 'anonymous';
    script.referrerPolicy = 'no-referrer';
    script.onload = function() {
      addCopyButtons(clipboard);
    };
    document.body.appendChild(script);
  }
}

document.addEventListener('DOMContentLoaded', onLoad);
