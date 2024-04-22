
  function debounce (func, wait, immediate) {
    let timeout
    return function () {
      const context = this
      const args = arguments
      const later = function () {
        timeout = null
        if (!immediate) func.apply(context, args)
      }
      const callNow = immediate && !timeout
      clearTimeout(timeout)
      timeout = setTimeout(later, wait)
      if (callNow) func.apply(context, args)
    }
  };

  function closeSubNav () {
    const topLevelNavItems = document.querySelectorAll('.header__nav-top-level')
    topLevelNavItems.forEach((topLevelItems) => {
      topLevelItems.classList.remove('header__nav-top-level--open')
    })
  }

  // Click event to toggle subnav
  const headerNav = document.querySelector('.header__nav')
  const topLevelNavItems = document.querySelectorAll('.header__nav-top-level')
  topLevelNavItems.forEach((topLevelNavItem) => {
    // Open on hover
    topLevelNavItem.addEventListener('mouseenter', () => {
      if (window.innerWidth > 1160) {
        headerNav.classList.add('header__nav--open')
        topLevelNavItem.classList.add('header__nav-top-level--open')
      }
    })

    // Close when leaving
    topLevelNavItem.addEventListener('mouseleave', () => {
      if (window.innerWidth > 1160) {
        headerNav.classList.remove('header__nav--open')
        closeSubNav()
      }
    })

    // Click to toggle
    topLevelNavItem.addEventListener('click', (e) => {
      if (window.innerWidth <= 1160 && e.target.closest('.header__nav-top-level').classList.contains('header__nav-top-level--has-children')) {
        // Prevent Default for mobile links that have children
        if (e.target.classList.contains('header__nav-top-level-link')) {
          e.preventDefault()
        }

        topLevelNavItems.forEach((topLevelItems) => {
          if (topLevelItems !== topLevelNavItem) {
            topLevelItems.classList.remove('header__nav-top-level--open')
          }
        })

        topLevelNavItem.classList.contains('header__nav-top-level--open') ? topLevelNavItem.classList.remove('header__nav-top-level--open') : topLevelNavItem.classList.add('header__nav-top-level--open')
      }
    })
  })
