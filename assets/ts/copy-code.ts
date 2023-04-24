function enableCodeCopy(clipboard: Clipboard): void {
  Array.from(document.getElementsByClassName('code-copy')).forEach((button: HTMLElement) => {
    const code = button.parentElement.parentElement.querySelector('pre > code');
    button.style.display = 'block';
    button.title = 'Copy code';
    button.addEventListener('click', () => {
      const text: string = Array.from(code.getElementsByClassName('cl')).map((e: HTMLElement) => e.innerText).join('');
      clipboard.writeText(text).then(function () {
        button.blur();
        button.title = 'Copied'
        button.classList.remove('icon-clipboard');
        button.classList.add('code-copied', 'icon-clipboard-check');
        setTimeout(function () {
          button.title = 'Copy code';
          button.classList.remove('code-copied', 'icon-clipboard-check');
          button.classList.add('icon-clipboard');
        }, 2000);
      }, function (reason) {
        button.classList.remove('icon-clipboard');
        button.classList.add('code-copy-error', 'icon-clipboard-x');
        button.disabled = true;
      });
    });
  });
}

function onLoad(): void {
  if (navigator && navigator.clipboard) {
    enableCodeCopy(navigator.clipboard);
  } else {
    const script = document.createElement('script');
    script.src = 'https://cdnjs.cloudflare.com/ajax/libs/clipboard-polyfill/4.0.0/es6/clipboard-polyfill.es6.min.js';
    script.integrity = 'sha512-eqdAiq5buC4UGO1vAIBz77R3ITN65dhwyD1M/v6AHaZ+6BQiqc3qVs90gJFrdC0nFMgTQ5vcHqBRkv/RjyRG7w==';
    script.crossOrigin = 'anonymous';
    script.referrerPolicy = 'no-referrer';
    script.onload = function() {
      enableCodeCopy(clipboard);
    };
    document.body.appendChild(script);
  }
}

document.addEventListener('DOMContentLoaded', onLoad);
