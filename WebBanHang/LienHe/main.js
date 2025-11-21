document.addEventListener('DOMContentLoaded', () => {
    
    /* =========================================
       1. PRELOADER & INITIAL SETUP
       ========================================= */
    const preloader = document.getElementById('preloader');
    if (preloader) {
        window.addEventListener('load', () => {
            preloader.style.opacity = '0';
            setTimeout(() => { preloader.style.display = 'none'; }, 500);
        });
    }

    // Thêm class cho body để CSS biết JS đã load
    document.body.classList.add('js-loaded');

    /* =========================================
       2. TECH BACKGROUND (Mạng lưới hạt kết nối)
       ========================================= */
    const canvas = document.getElementById('tech-canvas');
    if (canvas) {
        const ctx = canvas.getContext('2d');
        let width, height, particles = [];

        const resize = () => {
            width = canvas.width = window.innerWidth;
            height = canvas.height = window.innerHeight;
        };
        
        class Particle {
            constructor() {
                this.x = Math.random() * width;
                this.y = Math.random() * height;
                this.vx = (Math.random() - 0.5) * 0.5;
                this.vy = (Math.random() - 0.5) * 0.5;
                this.size = Math.random() * 2 + 1;
            }
            update() {
                this.x += this.vx;
                this.y += this.vy;
                if (this.x < 0 || this.x > width) this.vx *= -1;
                if (this.y < 0 || this.y > height) this.vy *= -1;
            }
            draw() {
                ctx.beginPath();
                ctx.arc(this.x, this.y, this.size, 0, Math.PI * 2);
                ctx.fillStyle = 'rgba(56, 189, 248, 0.5)'; // Màu xanh Neon
                ctx.fill();
            }
        }

        const initParticles = () => {
            particles = [];
            const count = window.innerWidth < 768 ? 30 : 80; // Giảm số lượng trên mobile
            for (let i = 0; i < count; i++) particles.push(new Particle());
        };

        const animate = () => {
            ctx.clearRect(0, 0, width, height);
            particles.forEach((p, i) => {
                p.update();
                p.draw();
                // Vẽ đường nối
                for (let j = i + 1; j < particles.length; j++) {
                    const p2 = particles[j];
                    const dist = Math.hypot(p.x - p2.x, p.y - p2.y);
                    if (dist < 150) {
                        ctx.beginPath();
                        ctx.strokeStyle = `rgba(56, 189, 248, ${1 - dist/150})`;
                        ctx.lineWidth = 0.5;
                        ctx.moveTo(p.x, p.y);
                        ctx.lineTo(p2.x, p2.y);
                        ctx.stroke();
                    }
                }
            });
            requestAnimationFrame(animate);
        };

        window.addEventListener('resize', () => { resize(); initParticles(); });
        resize();
        initParticles();
        animate();
    }

    /* =========================================
       3. NAVIGATION & UI INTERACTION
       ========================================= */
    // Sticky Nav
    const nav = document.getElementById('fox-nav');
    window.addEventListener('scroll', () => {
        if (window.scrollY > 50) nav.classList.add('scrolled');
        else nav.classList.remove('scrolled');
    });

    // Mobile Menu Toggle (Tự động tạo nút nếu chưa có)
    if (window.innerWidth < 768 && !document.querySelector('.mobile-menu-btn')) {
        const navList = nav.querySelector('ul');
        const btn = document.createElement('div');
        btn.className = 'mobile-menu-btn';
        btn.innerHTML = '☰';
        btn.style.cssText = "color:white; font-size:1.5rem; padding:10px; cursor:pointer; position:absolute; right:20px; top:10px;";
        
        nav.insertBefore(btn, navList);
        
        // CSS cho Mobile Menu
        navList.style.transition = "0.3s";
        
        btn.addEventListener('click', () => {
            if (navList.style.display === 'flex') {
                navList.style.display = 'none';
                btn.innerHTML = '☰';
            } else {
                navList.style.display = 'flex';
                navList.style.flexDirection = 'column';
                navList.style.background = '#0a0f1c';
                navList.style.position = 'absolute';
                navList.style.top = '60px';
                navList.style.left = '0';
                navList.style.width = '100%';
                btn.innerHTML = '✕';
            }
        });
    }

    // User Dropdown
    const userToggle = document.getElementById('user-toggle');
    const dropdown = document.querySelector('.dropdown-menu');
    if (userToggle && dropdown) {
        userToggle.addEventListener('click', (e) => {
            e.preventDefault();
            const isVisible = dropdown.style.display === 'block';
            dropdown.style.display = isVisible ? 'none' : 'block';
        });
        document.addEventListener('click', (e) => {
            if (!userToggle.contains(e.target) && !dropdown.contains(e.target)) {
                dropdown.style.display = 'none';
            }
        });
    }

    /* =========================================
       4. SCROLL REVEAL (Hiệu ứng trồi lên)
       ========================================= */
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('visible');
            }
        });
    }, { threshold: 0.1 });

    // Tự động tìm các phần tử chính để thêm hiệu ứng
    const animateElements = document.querySelectorAll('.product-card, .news-item, .fin-card, h2, .section, .contact-container');
    animateElements.forEach(el => {
        el.classList.add('fade-up'); // Thêm class animation gốc
        observer.observe(el);
    });

    /* =========================================
       5. PAGE SPECIFIC LOGIC
       ========================================= */
    
    // --- TRANG SẢN PHẨM (LỌC DANH MỤC) ---
    const categorySelect = document.getElementById('category-select');
    if (categorySelect) {
        const groups = document.querySelectorAll('.category-group');
        
        categorySelect.addEventListener('change', function() {
            const selected = this.value;
            
            groups.forEach(group => {
                const groupCat = group.getAttribute('data-category');
                if (selected === 'all' || groupCat === selected) {
                    group.style.display = 'block';
                    // Reset animation
                    group.classList.remove('visible');
                    setTimeout(() => group.classList.add('visible'), 50);
                } else {
                    group.style.display = 'none';
                }
            });
        });
    }

    // --- TRANG CHI TIẾT (HÌNH ẢNH & ACCORDION) ---
    // Zoom ảnh
    const productImg = document.querySelector('.product-image-block img');
    if (productImg) {
        productImg.addEventListener('mousemove', function(e) {
            const { left, top, width, height } = this.getBoundingClientRect();
            const x = (e.clientX - left) / width * 100;
            const y = (e.clientY - top) / height * 100;
            this.style.transformOrigin = `${x}% ${y}%`;
            this.style.transform = 'scale(1.5)';
        });
        productImg.addEventListener('mouseleave', function() {
            this.style.transform = 'scale(1)';
        });
    }

    // Accordion thông tin (Mô tả, Cấu hình...)
    const infoHeaders = document.querySelectorAll('.product-info-block h3');
    infoHeaders.forEach(header => {
        header.style.cursor = 'pointer';
        header.addEventListener('click', () => {
            // Tìm tất cả thẻ p phía sau h3 này
            let sibling = header.nextElementSibling;
            while (sibling) {
                if (sibling.tagName === 'H3' || sibling.tagName === 'DIV') break; // Dừng nếu gặp h3 hoặc div khác
                if (sibling.style.display === 'none') {
                    sibling.style.display = 'block';
                } else {
                    sibling.style.display = 'none';
                }
                sibling = sibling.nextElementSibling;
            }
        });
    });

    /* =========================================
       6. BACK TO TOP BUTTON
       ========================================= */
    let backBtn = document.getElementById('back-to-top');
    if (!backBtn) {
        backBtn = document.createElement('button');
        backBtn.id = 'back-to-top';
        backBtn.innerHTML = '↑';
        document.body.appendChild(backBtn);
    }

    window.addEventListener('scroll', () => {
        if (window.scrollY > 300) backBtn.classList.add('show');
        else backBtn.classList.remove('show');
    });

    backBtn.addEventListener('click', () => {
        window.scrollTo({ top: 0, behavior: 'smooth' });
    });
});