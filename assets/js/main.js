// Fate of Eberron - UI interactions

(function () {
  'use strict';

  // Hamburger menu toggle
  var toggle = document.querySelector('.nav-toggle');
  var navLinks = document.querySelector('.nav-links');

  if (toggle && navLinks) {
    toggle.addEventListener('click', function () {
      toggle.classList.toggle('active');
      navLinks.classList.toggle('open');
    });

    // Close menu when a link is clicked
    navLinks.querySelectorAll('a').forEach(function (link) {
      link.addEventListener('click', function () {
        toggle.classList.remove('active');
        navLinks.classList.remove('open');
      });
    });
  }

  // Scroll fade-in with IntersectionObserver
  var faders = document.querySelectorAll('.fade-in');

  if (faders.length > 0 && 'IntersectionObserver' in window) {
    var observer = new IntersectionObserver(function (entries) {
      entries.forEach(function (entry) {
        if (entry.isIntersecting) {
          entry.target.classList.add('visible');
          observer.unobserve(entry.target);
        }
      });
    }, {
      threshold: 0,
      rootMargin: '0px 0px -40px 0px'
    });

    faders.forEach(function (el) {
      observer.observe(el);
    });
  } else {
    // Fallback: show everything immediately
    faders.forEach(function (el) {
      el.classList.add('visible');
    });
  }
})();
