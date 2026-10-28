// The splash of index.html, out of the page so that its CSP can forbid inline scripts
// (docker/security_headers.conf). Loaded after the splash elements.

// The page follows the browser language like the app: Spanish, else English
if ((navigator.language || "").toLowerCase().startsWith("es")) {
  document.documentElement.lang = "es";
  // Flutter sets it again from slang once it runs (app.title)
  document.title = "Root101 · Ingeniería de software, desde la raíz";
}

// Remove the splash when Flutter renders its first frame
window.addEventListener('flutter-first-frame', function () {
  const splash = document.getElementById('splash');

  if (splash) {
    splash.classList.add('fade-out');

    setTimeout(() => {
      splash.remove();
      document.body.style.background = 'transparent';
    }, 400);
  }
});
