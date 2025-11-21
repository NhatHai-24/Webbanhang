window.addEventListener('load', function() {
    var preloader = document.getElementById('preloader');
    if (preloader) preloader.style.display = 'none';
});

document.addEventListener("DOMContentLoaded", function() {
    const toggle = document.getElementById("user-toggle");
    const menu = document.querySelector(".dropdown-menu");

    if (toggle && menu) {
        toggle.addEventListener("click", function(e) {
            e.preventDefault();
            menu.style.display = (menu.style.display === "none" || menu.style.display === "") ? "block" : "none";
        });

        // Đóng menu khi click ra ngoài
        document.addEventListener("click", function(e) {
            if (!toggle.contains(e.target) && !menu.contains(e.target)) {
                menu.style.display = "none";
            }
        });
    }
});