<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>WorkSphere Pro - Enterprise Management System</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body { 
            font-family: 'Poppins', sans-serif; 
            margin: 0;
            padding: 0;
            background: linear-gradient(135deg, #1a2a3a 0%, #2c3e50 100%);
            min-height: 100vh;
            overflow-x: hidden;
            color: #fff;
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }
        
        .header {
            background: rgba(26, 42, 58, 0.95);
            color: white;
            padding: 0;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 4px 30px rgba(0,0,0,0.25);
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            z-index: 1000;
            backdrop-filter: blur(15px);
            border-bottom: 1px solid rgba(52, 152, 219, 0.3);
            transition: all 0.4s ease;
        }
        
        .header.scrolled {
            background: rgba(15, 30, 45, 0.98);
            padding: 0;
            box-shadow: 0 8px 40px rgba(0,0,0,0.35);
        }
        
        .header-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
            width: 100%;
            padding: 15px 0;
        }
        
        .logo-container {
            display: flex;
            align-items: center;
            gap: 15px;
            text-decoration: none;
            margin-left: -50px;
            transform: translateX(-30px);
        }
        
        .video-modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.9);
            z-index: 2000;
            justify-content: center;
            align-items: center;
            opacity: 0;
            transition: opacity 0.3s ease;
        }
        
        .video-modal.active {
            display: flex;
            opacity: 1;
        }
        
        .video-modal-content {
            position: relative;
            width: 90%;
            max-width: 900px;
            background: #1a2a3a;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 20px 50px rgba(0,0,0,0.5);
            transform: scale(0.9);
            transition: transform 0.3s ease;
        }
        
        .video-modal.active .video-modal-content {
            transform: scale(1);
        }
        
        .video-modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 30px;
            background: rgba(26, 42, 58, 0.9);
            border-bottom: 1px solid rgba(52, 152, 219, 0.3);
        }
        
        .video-modal-title {
            font-size: 1.5rem;
            font-weight: 600;
            color: white;
        }
        
        .close-modal {
            background: none;
            border: none;
            color: white;
            font-size: 1.8rem;
            cursor: pointer;
            transition: color 0.3s ease;
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
        }
        
        .close-modal:hover {
            color: #FF6B35;
            background: rgba(255, 255, 255, 0.1);
        }
        
        .video-container {
            position: relative;
            width: 100%;
            padding-bottom: 56.25%;
            height: 0;
        }
        
        .video-container iframe {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            border: none;
        }
        
        .logo-icon {
            width: 50px;
            height: 50px;
            background: linear-gradient(135deg, #3498db 0%, #2c3e50 100%);
            border-radius: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            box-shadow: 0 6px 20px rgba(52, 152, 219, 0.4);
            overflow: hidden;
        }
        
        .logo-icon::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, rgba(255,255,255,0.3) 0%, transparent 50%);
        }
        
        .logo-icon i {
            color: white;
            font-size: 24px;
            filter: drop-shadow(0 2px 4px rgba(0,0,0,0.3));
            z-index: 1;
        }
        
        .logo-text {
            display: flex;
            flex-direction: column;
            line-height: 1;
            position: relative;
        }
        
        .logo-main {
            display: flex;
            align-items: baseline;
            gap: 4px;
            font-weight: 800;
            letter-spacing: -0.5px;
            position: relative;
        }
        
        .worksphere-text {
            font-size: 1.9rem;
            background: linear-gradient(135deg, #3498db 0%, #2c3e50 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            text-shadow: 0 2px 10px rgba(52, 152, 219, 0.3);
            position: relative;
        }
        
        .worksphere-text::after {
            content: '';
            position: absolute;
            bottom: -2px;
            left: 0;
            width: 100%;
            height: 2px;
            background: linear-gradient(90deg, #3498db, transparent);
            opacity: 0.7;
        }
        
        .pro-text {
            font-size: 1.5rem;
            background: linear-gradient(135deg, #FF6B35 0%, #FF8E53 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            text-shadow: 0 2px 8px rgba(255, 107, 53, 0.3);
            font-weight: 900;
            position: relative;
            padding: 0 4px;
        }
        
        .pro-text::before {
            content: '';
            position: absolute;
            top: -2px;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, rgba(255, 107, 53, 0.1) 0%, transparent 50%);
            border-radius: 4px;
            z-index: -1;
        }
        
        .logo-tagline {
            font-size: 0.65rem;
            font-weight: 700;
            color: rgba(255, 255, 255, 0.7);
            letter-spacing: 2px;
            text-transform: uppercase;
            margin-top: 3px;
            position: relative;
            padding-left: 2px;
        }
        
        .logo-tagline::before {
            content: '✦';
            position: absolute;
            left: -12px;
            top: 50%;
            transform: translateY(-50%);
            color: #3498db;
            font-size: 0.6rem;
        }
        
        .nav-links {
            display: flex;
            gap: 5px;
            align-items: center;
        }
        
        .nav-links a {
            color: white;
            text-decoration: none;
            padding: 12px 20px;
            border-radius: 10px;
            transition: all 0.3s ease;
            font-weight: 500;
            border: 1px solid transparent;
            display: flex;
            align-items: center;
            gap: 8px;
            position: relative;
            overflow: hidden;
        }
        
        .nav-links a::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.1), transparent);
            transition: left 0.5s;
        }
        
        .nav-links a:hover::before {
            left: 100%;
        }
        
        .nav-links a:hover {
            background: rgba(255, 255, 255, 0.1);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(52, 152, 219, 0.2);
        }
        
        .nav-links a.signin-btn {
            background: linear-gradient(135deg, #3498db 0%, #2980b9 100%);
            color: white;
            box-shadow: 0 4px 15px rgba(52, 152, 219, 0.3);
            border-radius: 10px;
            margin-left: 10px;
        }
        
        .nav-links a.signin-btn:hover {
            background: linear-gradient(135deg, #2980b9 0%, #3498db 100%);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(52, 152, 219, 0.4);
        }
        
        .nav-links a.signup-btn {
            background: linear-gradient(135deg, #FF6B35 0%, #FF8E53 100%);
            color: white;
            box-shadow: 0 4px 15px rgba(255, 107, 53, 0.3);
            border-radius: 10px;
        }
        
        .nav-links a.signup-btn:hover {
            background: linear-gradient(135deg, #FF8E53 0%, #FF6B35 100%);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(255, 107, 53, 0.4);
        }
        
        .hero {
            padding: 180px 0 100px;
            position: relative;
            overflow: hidden;
            background: url('https://images.unsplash.com/photo-1521737711867-e3b97375f902?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1740&q=80') no-repeat center center;
            background-size: cover;
        }
        
        .hero::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, rgba(52, 152, 219, 0.8) 0%, rgba(44, 62, 80, 0.9) 100%);
            z-index: 0;
        }
        
        .hero-content {
            position: relative;
            z-index: 1;
            max-width: 800px;
            margin: 0 auto;
            text-align: center;
        }
        
        .hero-title {
            font-size: 3.5rem;
            font-weight: 800;
            margin-bottom: 20px;
            line-height: 1.2;
            text-shadow: 0 4px 10px rgba(0,0,0,0.2);
        }
        
        .hero-subtitle {
            font-size: 1.3rem;
            margin-bottom: 40px;
            max-width: 700px;
            margin-left: auto;
            margin-right: auto;
            opacity: 0.9;
            line-height: 1.6;
        }
        
        .hero-buttons {
            display: flex;
            gap: 20px;
            justify-content: center;
            margin-bottom: 60px;
        }
        
        .btn {
            padding: 15px 35px;
            border-radius: 50px;
            text-decoration: none;
            font-weight: 600;
            font-size: 1.1rem;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
        }
        
        .btn-primary {
            background: linear-gradient(135deg, #3498db 0%, #2980b9 100%);
            color: white;
            border: 2px solid transparent;
        }
        
        .btn-primary:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(52, 152, 219, 0.4);
        }
        
        .btn-secondary {
            background: rgba(255, 255, 255, 0.15);
            color: white;
            border: 2px solid rgba(255, 255, 255, 0.3);
            backdrop-filter: blur(10px);
        }
        
        .btn-secondary:hover {
            background: rgba(255, 255, 255, 0.25);
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(255, 255, 255, 0.2);
        }
        
        .btn-accent {
            background: linear-gradient(135deg, #FF6B35 0%, #FF8E53 100%);
            color: white;
            border: 2px solid transparent;
        }
        
        .btn-accent:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(255, 107, 53, 0.4);
        }
        
        .features {
            padding: 100px 0;
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(10px);
        }
        
        .section-title {
            text-align: center;
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 60px;
            position: relative;
        }
        
        .section-title::after {
            content: '';
            position: absolute;
            bottom: -15px;
            left: 50%;
            transform: translateX(-50%);
            width: 80px;
            height: 4px;
            background: linear-gradient(135deg, #3498db 0%, #FF6B35 100%);
            border-radius: 2px;
        }
        
        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 30px;
        }
        
        .feature-card {
            background: rgba(255, 255, 255, 0.08);
            padding: 40px 30px;
            border-radius: 20px;
            text-align: center;
            transition: all 0.4s ease;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255,255,255,0.1);
            position: relative;
            overflow: hidden;
        }
        
        .feature-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(52, 152, 219, 0.1), transparent);
            transition: left 0.5s;
        }
        
        .feature-card:hover::before {
            left: 100%;
        }
        
        .feature-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 30px rgba(0,0,0,0.2);
            background: rgba(255, 255, 255, 0.12);
        }
        
        .feature-icon {
            font-size: 3.5rem;
            margin-bottom: 25px;
            background: linear-gradient(135deg, #3498db 0%, #FF6B35 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            display: inline-block;
            transition: transform 0.3s ease;
        }
        
        .feature-card:hover .feature-icon {
            transform: scale(1.1);
        }
        
        .feature-title {
            font-size: 1.5rem;
            font-weight: 600;
            margin-bottom: 15px;
        }
        
        .feature-description {
            font-size: 1rem;
            opacity: 0.8;
            line-height: 1.6;
        }
        
        .dashboard-preview {
            padding: 100px 0;
            background: rgba(26, 42, 58, 0.7);
        }
        
        .preview-content {
            display: flex;
            align-items: center;
            gap: 50px;
        }
        
        .preview-text {
            flex: 1;
        }
        
        .preview-image {
            flex: 1;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 20px 40px rgba(0,0,0,0.3);
            transition: all 0.4s ease;
        }
        
        .preview-image:hover {
            transform: translateY(-10px) scale(1.02);
            box-shadow: 0 25px 50px rgba(0,0,0,0.4);
        }
        
        .preview-image img {
            width: 100%;
            height: auto;
            display: block;
        }
        
        .testimonials {
            padding: 100px 0;
            background: rgba(255, 255, 255, 0.05);
        }
        
        .testimonials-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 30px;
        }
        
        .testimonial-card {
            background: rgba(255, 255, 255, 0.08);
            padding: 30px;
            border-radius: 15px;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255,255,255,0.1);
        }
        
        .testimonial-text {
            font-style: italic;
            margin-bottom: 20px;
            line-height: 1.6;
        }
        
        .testimonial-author {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        
        .author-avatar {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background: linear-gradient(135deg, #3498db 0%, #FF6B35 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
        }
        
        .author-info h4 {
            margin-bottom: 5px;
        }
        
        .author-info p {
            opacity: 0.7;
            font-size: 0.9rem;
        }
        
        .cta {
            padding: 100px 0;
            text-align: center;
            background: url('https://images.unsplash.com/photo-1552664730-d307ca884978?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1740&q=80') no-repeat center center;
            background-size: cover;
            position: relative;
        }
        
        .cta::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, rgba(52, 152, 219, 0.9) 0%, rgba(44, 62, 80, 0.9) 100%);
            z-index: 0;
        }
        
        .cta-content {
            position: relative;
            z-index: 1;
        }
        
        .cta-title {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 20px;
        }
        
        .cta-subtitle {
            font-size: 1.2rem;
            margin-bottom: 40px;
            max-width: 600px;
            margin-left: auto;
            margin-right: auto;
            opacity: 0.9;
        }
        
        .footer {
            background: linear-gradient(135deg, #0f1e2d 0%, #1a2a3a 100%);
            padding: 60px 0 30px;
            border-top: 1px solid rgba(52, 152, 219, 0.3);
            position: relative;
            overflow: hidden;
        }
        
        .footer::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 4px;
            background: linear-gradient(90deg, #3498db, #FF6B35, #3498db);
            background-size: 200% 100%;
            animation: gradientShift 3s ease infinite;
        }
        
        .footer-content {
            display: grid;
            grid-template-columns: 2fr 1fr 1fr 1fr;
            gap: 40px;
            margin-bottom: 40px;
        }
        
        .footer-column h3 {
            font-size: 1.2rem;
            margin-bottom: 25px;
            position: relative;
            padding-bottom: 10px;
        }
        
        .footer-column h3::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 40px;
            height: 3px;
            background: linear-gradient(135deg, #3498db 0%, #FF6B35 100%);
            border-radius: 2px;
        }
        
        .footer-logo {
            display: flex;
            align-items: center;
            gap: 15px;
            margin-bottom: 20px;
        }
        
        .footer-description {
            opacity: 0.8;
            line-height: 1.6;
            margin-bottom: 25px;
        }
        
        .social-links {
            display: flex;
            gap: 15px;
        }
        
        .social-links a {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 40px;
            height: 40px;
            border-radius: 10px;
            background: rgba(255, 255, 255, 0.1);
            color: white;
            text-decoration: none;
            transition: all 0.3s ease;
        }
        
        .social-links a:hover {
            background: linear-gradient(135deg, #FF6B35 0%, #FF8E53 100%);
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(242, 171, 78, 0.4);
        }
        
        .footer-links {
            list-style: none;
        }
        
        .footer-links li {
            margin-bottom: 12px;
        }
        
        .footer-links a {
            color: rgba(255, 255, 255, 0.8);
            text-decoration: none;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .footer-links a:hover {
            color: #f5901d;
            transform: translateX(5px);
        }
        
        .footer-links a i {
            font-size: 0.8rem;
            color: #3498db;
        }
        
        .contact-info {
            list-style: none;
        }
        
        .contact-info li {
            margin-bottom: 15px;
            display: flex;
            align-items: flex-start;
            gap: 12px;
        }
        
        .contact-info i {
            color: #3498db;
            margin-top: 3px;
            flex-shrink: 0;
        }
        
        .contact-info span {
            opacity: 0.8;
            line-height: 1.5;
        }
        
        .footer-bottom {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-top: 30px;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
        }
        
        .copyright {
            opacity: 0.7;
            font-size: 0.9rem;
        }
        
        .footer-bottom-links {
            display: flex;
            gap: 20px;
        }
        
        .footer-bottom-links a {
            color: rgba(255, 255, 255, 0.7);
            text-decoration: none;
            font-size: 0.9rem;
            transition: all 0.3s ease;
        }
        
        .footer-bottom-links a:hover {
            color: #3498db;
        }
        
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        @keyframes gradientShift {
            0% {
                background-position: 0% 50%;
            }
            50% {
                background-position: 100% 50%;
            }
            100% {
                background-position: 0% 50%;
            }
        }
        
        @keyframes pulse {
            0% {
                transform: scale(1);
            }
            50% {
                transform: scale(1.05);
            }
            100% {
                transform: scale(1);
            }
        }
        
        .fade-in-up {
            animation: fadeInUp 0.8s ease-out;
        }
        
        .pulse {
            animation: pulse 2s infinite;
        }
        
        @media (max-width: 992px) {
            .footer-content {
                grid-template-columns: 1fr 1fr;
                gap: 40px 30px;
            }
            
            .preview-content {
                flex-direction: column;
            }
        }
        
        @media (max-width: 768px) {
            .header {
                padding: 0;
            }
            
            .header-content {
                flex-direction: column;
                padding: 15px 0;
                gap: 15px;
            }
            
            .nav-links {
                width: 100%;
                justify-content: center;
                flex-wrap: wrap;
            }
            
            .nav-links a {
                padding: 10px 15px;
                font-size: 0.9rem;
            }
            
            .worksphere-text {
                font-size: 1.5rem;
            }
            
            .pro-text {
                font-size: 1.2rem;
            }
            
            .logo-tagline {
                font-size: 0.6rem;
            }
            
            .footer-content {
                grid-template-columns: 1fr;
                gap: 40px;
            }
            
            .footer-bottom {
                flex-direction: column;
                gap: 20px;
                text-align: center;
            }
            
            .hero-title {
                font-size: 2.5rem;
            }
            
            .hero-subtitle {
                font-size: 1.1rem;
            }
            
            .hero-buttons {
                flex-direction: column;
                align-items: center;
            }
            
            .btn {
                width: 100%;
                max-width: 300px;
                justify-content: center;
            }
            
            .video-modal-content {
                width: 95%;
            }
        }
        
        @media (max-width: 480px) {
            .nav-links {
                flex-direction: column;
                width: 100%;
            }
            
            .nav-links a {
                width: 100%;
                justify-content: center;
            }
            
            .video-modal-header {
                padding: 15px 20px;
            }
            
            .video-modal-title {
                font-size: 1.2rem;
            }
        }
    </style>
</head>
<body>
    <div class="video-modal" id="videoModal">
        <div class="video-modal-content">
            <div class="video-modal-header">
                <h3 class="video-modal-title">WorkSphere Pro Demo</h3>
                <button class="close-modal" id="closeModal">&times;</button>
            </div>
            <div class="video-container">
                <iframe src="https://www.youtube.com/embed/dQw4w9WgXcQ" 
                        title="WorkSphere Pro Demo" 
                        allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" 
                        allowfullscreen>
                </iframe>
            </div>
        </div>
    </div>

    <header class="header" id="header">
        <div class="container">
            <div class="header-content">
                <a href="#" class="logo-container">
                    <div class="logo-icon">
                        <i class="fas fa-globe-americas"></i>
                    </div>
                    <div class="logo-text">
                        <div class="logo-main">
                            <span class="worksphere-text">WorkSphere</span>
                            <span class="pro-text">Pro</span>
                        </div>
                        <div class="logo-tagline">Enterprise Suite</div>
                    </div>
                </a>
                
                <div class="nav-links">
                    <a href="#features">
                        <i class="fas fa-star"></i>Features
                    </a>
                    <a href="#dashboard">
                        <i class="fas fa-tachometer-alt"></i>Dashboard
                    </a>
                    <a href="#testimonials">
                        <i class="fas fa-comments"></i>Testimonials
                    </a>
                    <a href="login.jsp" class="signin-btn">
                        <i class="fas fa-sign-in-alt"></i>Sign In
                    </a>
                    <a href="registration.jsp" class="signup-btn">
                        <i class="fas fa-user-plus"></i>Sign Up
                    </a>
                </div>
            </div>
        </div>
    </header>

    <section class="hero">
        <div class="container">
            <div class="hero-content">
                <h1 class="hero-title fade-in-up">Streamline Your Enterprise Management</h1>
                <p class="hero-subtitle fade-in-up">WorkSphere Pro provides a comprehensive solution for managing employees, departments, and organizational workflows with powerful analytics and intuitive controls.</p>
                
                <div class="hero-buttons fade-in-up">
                    <a href="registration.jsp" class="btn btn-accent">
                        <i class="fas fa-rocket"></i>Get Started Free
                    </a>
                    <a href="#" class="btn btn-secondary" id="watchDemoBtn">
                        <i class="fas fa-play-circle"></i>Watch Demo
                    </a>
                </div>
            </div>
        </div>
    </section>

    <section class="features" id="features">
        <div class="container">
            <h2 class="section-title">Powerful Features</h2>
            
            <div class="features-grid">
                <div class="feature-card fade-in-up">
                    <div class="feature-icon">
                        <i class="fas fa-users"></i>
                    </div>
                    <h3 class="feature-title">Employee Management</h3>
                    <p class="feature-description">Efficiently manage employee records, profiles, and information with our intuitive dashboard and powerful search capabilities.</p>
                </div>
                
                <div class="feature-card fade-in-up">
                    <div class="feature-icon">
                        <i class="fas fa-sitemap"></i>
                    </div>
                    <h3 class="feature-title">Department Organization</h3>
                    <p class="feature-description">Create and manage departments, assign team leads, and maintain organizational structure with ease.</p>
                </div>
                
                <div class="feature-card fade-in-up">
                    <div class="feature-icon">
                        <i class="fas fa-chart-bar"></i>
                    </div>
                    <h3 class="feature-title">Advanced Analytics</h3>
                    <p class="feature-description">Gain insights into your organization with comprehensive reports and data visualization tools.</p>
                </div>
            </div>
        </div>
    </section>

    <section class="dashboard-preview" id="dashboard">
        <div class="container">
            <div class="preview-content">
                <div class="preview-text">
                    <h2 class="section-title" style="text-align: left;">Intuitive Dashboard</h2>
                    <p style="margin-bottom: 30px; line-height: 1.6; opacity: 0.9;">Our clean, modern dashboard provides a comprehensive overview of your organization's key metrics and activities at a glance.</p>
                    <ul style="list-style-type: none; margin-bottom: 30px;">
                        <li style="margin-bottom: 15px; display: flex; align-items: center; gap: 10px;">
                            <i class="fas fa-check-circle" style="color: #3498db;"></i>
                            <span>Real-time employee statistics</span>
                        </li>
                        <li style="margin-bottom: 15px; display: flex; align-items: center; gap: 10px;">
                            <i class="fas fa-check-circle" style="color: #3498db;"></i>
                            <span>Department performance metrics</span>
                        </li>
                        <li style="margin-bottom: 15px; display: flex; align-items: center; gap: 10px;">
                            <i class="fas fa-check-circle" style="color: #3498db;"></i>
                            <span>Recent activity tracking</span>
                        </li>
                    </ul>
                    <a href="#" class="btn btn-secondary" id="viewDemoBtn">
                        <i class="fas fa-eye"></i>View Live Demo
                    </a>
                </div>
                <div class="preview-image">
                    <img src="https://images.unsplash.com/photo-1551288049-bebda4e38f71?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1740&q=80" alt="Dashboard Preview">
                </div>
            </div>
        </div>
    </section>

    <section class="testimonials" id="testimonials">
        <div class="container">
            <h2 class="section-title">What Our Clients Say</h2>
            
            <div class="testimonials-grid">
                <div class="testimonial-card fade-in-up">
                    <div class="testimonial-text">
                        "WorkSphere Pro has transformed how we manage our 500+ employees. The intuitive interface and powerful reporting tools have saved us countless hours."
                    </div>
                    <div class="testimonial-author">
                        <div class="author-avatar">JS</div>
                        <div class="author-info">
                            <h4>John Smith</h4>
                            <p>CTO, TechSolutions Inc.</p>
                        </div>
                    </div>
                </div>
                
                <div class="testimonial-card fade-in-up">
                    <div class="testimonial-text">
                        "The department management features are exceptional. We've streamlined our workflows and improved inter-department communication significantly."
                    </div>
                    <div class="testimonial-author">
                        <div class="author-avatar">MJ</div>
                        <div class="author-info">
                            <h4>Maria Johnson</h4>
                            <p>HR Director, GlobalCorp</p>
                        </div>
                    </div>
                </div>
                
                <div class="testimonial-card fade-in-up">
                    <div class="testimonial-text">
                        "As a growing startup, we needed a scalable solution. WorkSphere Pro has grown with us and continues to meet our evolving needs perfectly."
                    </div>
                    <div class="testimonial-author">
                        <div class="author-avatar">RD</div>
                        <div class="author-info">
                            <h4>Robert Davis</h4>
                            <p>CEO, InnovateStart</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="cta">
        <div class="container">
            <div class="cta-content">
                <h2 class="cta-title">Ready to Transform Your Organization?</h2>
                <p class="cta-subtitle">Join thousands of companies that use WorkSphere Pro to streamline their enterprise management processes.</p>
                <div class="hero-buttons">
                    <a href="registration.jsp" class="btn btn-accent pulse">
                        <i class="fas fa-user-plus"></i>Sign Up Now
                    </a>
                    <a href="login.jsp" class="btn btn-primary">
                        <i class="fas fa-sign-in-alt"></i>Sign In
                    </a>
                </div>
            </div>
        </div>
    </section>

    <footer class="footer">
        <div class="container">
            <div class="footer-content">
                <div class="footer-column">
                    <div class="footer-logo">
                        <div class="logo-icon" style="width: 40px; height: 40px;">
                            <i class="fas fa-globe-americas" style="font-size: 18px;"></i>
                        </div>
                        <div class="logo-text">
                            <div class="logo-main">
                                <span class="worksphere-text" style="font-size: 1.5rem;">WorkSphere</span>
                                <span class="pro-text" style="font-size: 1.2rem;">Pro</span>
                            </div>
                            <div class="logo-tagline">Enterprise Suite</div>
                        </div>
                    </div>
                    <p class="footer-description">WorkSphere Pro is a comprehensive enterprise management solution designed to streamline your organization's workflows, enhance productivity, and drive business growth.</p>
                    <div class="social-links">
                        <a href="#"><i class="fab fa-facebook-f"></i></a>
                        <a href="#"><i class="fab fa-twitter"></i></a>
                        <a href="#"><i class="fab fa-linkedin-in"></i></a>
                        <a href="#"><i class="fab fa-instagram"></i></a>
                    </div>
                </div>
                
                <div class="footer-column">
                    <h3>Quick Links</h3>
                    <ul class="footer-links">
                        <li><a href="#"><i class="fas fa-chevron-right"></i>Home</a></li>
                        <li><a href="#features"><i class="fas fa-chevron-right"></i>Features</a></li>
                        <li><a href="#dashboard"><i class="fas fa-chevron-right"></i>Dashboard</a></li>
                        <li><a href="#testimonials"><i class="fas fa-chevron-right"></i>Testimonials</a></li>
                    </ul>
                </div>
                
                <div class="footer-column">
                    <h3>Resources</h3>
                    <ul class="footer-links">
                        <li><a href="#"><i class="fas fa-chevron-right"></i>Documentation</a></li>
                        <li><a href="#"><i class="fas fa-chevron-right"></i>Help Center</a></li>
                        <li><a href="#"><i class="fas fa-chevron-right"></i>Community</a></li>
                        <li><a href="#"><i class="fas fa-chevron-right"></i>Blog</a></li>
                        <li><a href="#"><i class="fas fa-chevron-right"></i>Webinars</a></li>
                    </ul>
                </div>
                
                <div class="footer-column">
                    <h3>Contact Us</h3>
                    <ul class="contact-info">
                        <li>
                            <i class="fas fa-map-marker-alt"></i>
                            <span>123 Business Avenue, Suite 100<br>San Francisco, CA 94107</span>
                        </li>
                        <li>
                            <i class="fas fa-phone"></i>
                            <span>+1 (555) 123-4567</span>
                        </li>
                        <li>
                            <i class="fas fa-envelope"></i>
                            <span>info@workspherepro.com</span>
                        </li>
                    </ul>
                </div>
            </div>
            
            <div class="footer-bottom">
                <div class="copyright">
                    &copy; 2025 WorkSphere Pro. All rights reserved.
                </div>
                <div class="footer-bottom-links">
                    <a href="#">Privacy Policy</a>
                    <a href="#">Terms of Service</a>
                    <a href="#">Cookie Policy</a>
                </div>
            </div>
        </div>
    </footer>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const header = document.getElementById('header');
            const videoModal = document.getElementById('videoModal');
            const closeModal = document.getElementById('closeModal');
            const watchDemoBtn = document.getElementById('watchDemoBtn');
            const viewDemoBtn = document.getElementById('viewDemoBtn');
            
            window.addEventListener('scroll', function() {
                if (window.scrollY > 50) {
                    header.classList.add('scrolled');
                } else {
                    header.classList.remove('scrolled');
                }
            });
            
            document.querySelectorAll('a[href^="#"]').forEach(anchor => {
                anchor.addEventListener('click', function (e) {
                    e.preventDefault();
                    const target = document.querySelector(this.getAttribute('href'));
                    if (target) {
                        target.scrollIntoView({
                            behavior: 'smooth',
                            block: 'start'
                        });
                    }
                });
            });
            
            function openVideoModal() {
                videoModal.classList.add('active');
                document.body.style.overflow = 'hidden';
            }
            
            function closeVideoModal() {
                videoModal.classList.remove('active');
                document.body.style.overflow = '';
                
                const iframe = videoModal.querySelector('iframe');
                if (iframe) {
                    iframe.src = iframe.src;
                }
            }
            
            watchDemoBtn.addEventListener('click', function(e) {
                e.preventDefault();
                openVideoModal();
            });
            
            viewDemoBtn.addEventListener('click', function(e) {
                e.preventDefault();
                openVideoModal();
            });
            
            closeModal.addEventListener('click', closeVideoModal);
            
            videoModal.addEventListener('click', function(e) {
                if (e.target === videoModal) {
                    closeVideoModal();
                }
            });
            
            document.addEventListener('keydown', function(e) {
                if (e.key === 'Escape' && videoModal.classList.contains('active')) {
                    closeVideoModal();
                }
            });
        });
    </script>
</body>
</html>