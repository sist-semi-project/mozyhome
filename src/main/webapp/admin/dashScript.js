document.addEventListener('DOMContentLoaded', function() {
    var menuItems = document.querySelectorAll('.menu-item > a');

    for (var i = 0; i < menuItems.length; i++) {
        menuItems[i].addEventListener('click', function(e) {
            e.preventDefault();

            var currentMenuItem = this.parentNode;
            var submenu = this.nextElementSibling;

            if (submenu.style.display === 'block') {
                submenu.style.display = 'none';
                this.querySelector('.toggle-icon').textContent = '+';
            } else {
                // Close other open submenus
                var openSubmenu = document.querySelector('.menu-item > ul[style="display: block;"]');
                if (openSubmenu) {
                    openSubmenu.style.display = 'none';
                    openSubmenu.previousElementSibling.querySelector('.toggle-icon').textContent = '+';
                }

                submenu.style.display = 'block';
                this.querySelector('.toggle-icon').textContent = '-';
            }

            // Toggle active class
            var activeItem = document.querySelector('.menu-item.active');
            if (activeItem) {
                activeItem.classList.remove('active');
            }
            /*currentMenuItem.classList.add('active');*/

        });
    }
});
