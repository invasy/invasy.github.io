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
        button.classList.add('code-copied');
        setTimeout(function () {
          button.title = 'Copy code';
          button.classList.remove('code-copied');
        }, 2000);
      }, function (error) {
        button.classList.add('code-copy-error');
        button.disabled = true;
      });
    });
  });
}

function onLoad(): void {
  if (navigator && navigator.clipboard) {
    enableCodeCopy(navigator.clipboard);
  } else {
    let script = document.createElement('script');
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
