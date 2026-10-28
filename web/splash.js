// The splash of index.html, out of the page so that its CSP can forbid inline scripts
// (docker/security_headers.conf). Loaded after the splash elements.

// The page follows the browser language (es/en), like the app
if ((navigator.language || "").toLowerCase().startsWith("es")) {
  document.documentElement.lang = "es";
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
