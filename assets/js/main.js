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

// Back to top button
(function() {
  var btn = document.querySelector('.back-to-top');
  if (!btn) return;

  window.addEventListener('scroll', function() {
    if (window.scrollY > 400) {
      btn.classList.add('visible');
    } else {
      btn.classList.remove('visible');
    }
  });

  btn.addEventListener('click', function() {
    window.scrollTo({ top: 0, behavior: 'smooth' });
  });
})();

// Search
(function() {
  var toggle = document.querySelector('.search-toggle');
  var overlay = document.querySelector('.search-overlay');
  var input = document.querySelector('.search-input');
  var resultsEl = document.querySelector('.search-results');
  if (!toggle || !overlay || !input) return;

  var idx = null;
  var docs = null;

  toggle.addEventListener('click', function() {
    overlay.classList.toggle('active');
    if (overlay.classList.contains('active')) {
      input.focus();
      if (!idx) loadIndex();
    }
  });

  document.addEventListener('click', function(e) {
    if (!e.target.closest('.search-container')) {
      overlay.classList.remove('active');
    }
  });

  function loadIndex() {
    var base = document.querySelector('link[rel="icon"]')
      ? document.querySelector('link[rel="icon"]').href.replace(/favicon\.svg$/, '')
      : '/Fate-of-Eberron/';
    fetch(base + 'search.json')
      .then(function(r) { return r.json(); })
      .then(function(data) {
        docs = data;
        idx = lunr(function() {
          this.ref('url');
          this.field('title', { boost: 10 });
          this.field('content');
          data.forEach(function(doc) { this.add(doc); }, this);
        });
      });
  }

  var debounce;
  input.addEventListener('input', function() {
    clearTimeout(debounce);
    debounce = setTimeout(function() {
      if (!idx) return;
      var query = input.value.trim();
      if (query.length < 2) { resultsEl.innerHTML = ''; return; }
      var results = idx.search(query + '~1');
      resultsEl.innerHTML = results.slice(0, 8).map(function(r) {
        var doc = docs.find(function(d) { return d.url === r.ref; });
        if (!doc) return '';
        var snippet = getSnippet(doc.content, query);
        return '<a href="' + doc.url + '"><div class="search-title">' +
          doc.title + '</div><div class="search-snippet">' + snippet + '</div></a>';
      }).join('');
      if (results.length === 0) {
        resultsEl.innerHTML = '<div style="padding:0.5rem;color:var(--text-secondary)">No results</div>';
      }
    }, 200);
  });

  function getSnippet(content, query) {
    var lower = content.toLowerCase();
    var pos = lower.indexOf(query.toLowerCase());
    if (pos === -1) return content.substring(0, 120) + '...';
    var start = Math.max(0, pos - 40);
    var end = Math.min(content.length, pos + 80);
    return (start > 0 ? '...' : '') + content.substring(start, end) + (end < content.length ? '...' : '');
  }
})();
