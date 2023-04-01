import {Theme} from './theme';

function clickEmail(): boolean {
  const name: string = this.dataset.name;
  const host: string = this.dataset.host.split('; ').reverse().join('.');
  const url = new URL(`mailto:${name}@${host}`);

  const subject: string = this.dataset.subject;
  if (subject != null) {
    url.search = `?subject=${subject}`;
  }

  window.location.href = url.toString();

  return false;
}

function decodeEmails(className: string): void {
  Array.from(document.getElementsByClassName(className)).forEach((e: HTMLElement) => e.onclick = clickEmail);
}

function onLoad(): void {
  Theme.set();
  (document.getElementById('theme-toggler') as HTMLElement).onclick = Theme.toggle;

  decodeEmails('text-addr');
}

document.addEventListener('DOMContentLoaded', onLoad);
