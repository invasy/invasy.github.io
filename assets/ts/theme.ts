export class Theme {
  private static _theme: string;

  private static getPreferred(): string {
    return window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light';
  }

  private static inverse(): string {
    return Theme._theme === 'light' ? 'dark' : 'light';
  }

  public static get(): string {
    return Theme._theme;
  }

  public static set(theme?: string | null): void {
    if (!theme) theme = localStorage.getItem('theme');
    if (!theme || theme === 'auto') theme = Theme.getPreferred();
    Theme._theme = theme;
    document.documentElement.setAttribute('data-bs-theme', Theme._theme);
    const button = document.getElementById('theme-toggler');
    button.classList.remove('icon-' + Theme._theme);
    button.classList.add('icon-' + Theme.inverse());
    localStorage.setItem('theme', Theme._theme);
  }

  public static toggle(): void {
    Theme.set(Theme.inverse());
  }
}