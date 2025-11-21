document.addEventListener('DOMContentLoaded', () => {

    // 1. TECH BACKGROUND CANVAS (Mạng lưới kết nối)
    const canvas = document.getElementById('tech-canvas');
    const ctx = canvas.getContext('2d');
    
    let width, height;
    let particles = [];

    function resize() {
        width = canvas.width = window.innerWidth;
        height = canvas.height = window.innerHeight;
    }

    class Particle {
        constructor() {
            this.x = Math.random() * width;
            this.y = Math.random() * height;
            this.vx = (Math.random() - 0.5) * 0.5; // Tốc độ chậm
            this.vy = (Math.random() - 0.5) * 0.5;
            this.size = Math.random() * 2 + 1;
        }
        update() {
            this.x += this.vx;
            this.y += this.vy;
            // Nếu chạm biên thì nảy lại
            if (this.x < 0 || this.x > width) this.vx *= -1;
            if (this.y < 0 || this.y > height) this.vy *= -1;
        }
        draw() {
            ctx.beginPath();
            ctx.arc(this.x, this.y, this.size, 0, Math.PI * 2);
            ctx.fillStyle = 'rgba(56, 189, 248, 0.5)'; // Màu xanh dot
            ctx.fill();
        }
    }

    function initParticles() {
        particles = [];
        const numberOfParticles = window.innerWidth < 768 ? 30 : 80; // Giảm số lượng trên mobile
        for (let i = 0; i < numberOfParticles; i++) {
            particles.push(new Particle());
        }
    }

    function animate() {
        ctx.clearRect(0, 0, width, height);
        
        particles.forEach((p, index) => {
            p.update();
            p.draw();
            
            // Vẽ đường nối giữa các điểm gần nhau
            for (let j = index + 1; j < particles.length; j++) {
                const p2 = particles[j];
                const dist = Math.hypot(p.x - p2.x, p.y - p2.y);
                if (dist < 150) {
                    ctx.beginPath();
                    ctx.strokeStyle = `rgba(56, 189, 248, ${1 - dist/150})`; // Mờ dần khi xa
                    ctx.lineWidth = 0.5;
                    ctx.moveTo(p.x, p.y);
                    ctx.lineTo(p2.x, p2.y);
                    ctx.stroke();
                }
            }
        });
        requestAnimationFrame(animate);
    }

    window.addEventListener('resize', () => {
        resize();
        initParticles();
    });
    resize();
    initParticles();
    animate();

    // 2. CUSTOM CURSOR (Con trỏ chuột tùy chỉnh)
    const cursorDot = document.getElementById("cursor-dot");
    const cursorOutline = document.getElementById("cursor-outline");

    window.addEventListener("mousemove", function(e) {
        const posX = e.clientX;
        const posY = e.clientY;

        // Dot đi theo ngay lập tức
        cursorDot.style.left = `${posX}px`;
        cursorDot.style.top = `${posY}px`;

        // Outline đi theo chậm một chút (hiệu ứng kéo theo)
        cursorOutline.animate({
            left: `${posX}px`,
            top: `${posY}px`
        }, { duration: 500, fill: "forwards" });
    });

    // 3. SCROLL REVEAL (Hiệu ứng xuất hiện khi cuộn)
    const observerOptions = { threshold: 0.15 };
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('visible');
                
                // Nếu là phần Stats thì kích hoạt đếm số
                if(entry.target.querySelector('.counter')) {
                    startCounters();
                }
            }
        });
    }, observerOptions);

    document.querySelectorAll('.fade-up, .fade-left, .fade-right').forEach(el => {
        observer.observe(el);
    });

    // 4. COUNTER ANIMATION (Số nhảy)
    let counted = false;
    function startCounters() {
        if(counted) return;
        const counters = document.querySelectorAll('.counter');
        counters.forEach(counter => {
            const target = +counter.getAttribute('data-target');
            const duration = 2000; // 2 giây
            const increment = target / (duration / 16); // 60fps
            
            let current = 0;
            const updateCounter = () => {
                current += increment;
                if (current < target) {
                    counter.innerText = Math.ceil(current);
                    requestAnimationFrame(updateCounter);
                } else {
                    counter.innerText = target;
                }
            };
            updateCounter();
        });
        counted = true;
    }

    // 5. STICKY NAVIGATION
    const nav = document.getElementById('fox-nav');
    window.addEventListener('scroll', () => {
        if (window.scrollY > 50) {
            nav.classList.add('scrolled');
        } else {
            nav.classList.remove('scrolled');
        }
    });

    // 6. MOBILE MENU
    const menuToggle = document.getElementById('mobile-menu');
    const navLinks = document.querySelector('.nav-links');
    
    if(menuToggle) {
        menuToggle.addEventListener('click', () => {
            navLinks.classList.toggle('active');
        });
    }
    
    // User Dropdown Toggle
    const userToggle = document.getElementById('user-toggle');
    const dropdownMenu = document.querySelector('.dropdown-menu');
    if(userToggle) {
        userToggle.addEventListener('click', (e) => {
            e.preventDefault();
            dropdownMenu.style.opacity = dropdownMenu.style.opacity === '1' ? '0' : '1';
            dropdownMenu.style.visibility = dropdownMenu.style.visibility === 'visible' ? 'hidden' : 'visible';
        });
    }
});