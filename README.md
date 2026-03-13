# Clinic Management System

Full-stack clinic management system with Spring Boot backend and React frontend.

## Features

### Backend (Spring Boot)
- ✅ Role-based Authentication (ADMIN, DOCTOR, PATIENT)
- ✅ JWT Token Authentication
- ✅ Two-Factor Authentication (2FA) via Email OTP
- ✅ Password Reset via Email
- ✅ Global Search Engine
- ✅ Table-level Search with Pagination
- ✅ Dashboard Analytics API
- ✅ Activity Logging / Audit Trail
- ✅ User Management (Admin only)
- ✅ Doctor, Patient, Appointment Management
- ✅ Location Hierarchy Management

### Frontend (React + Vite + Tailwind)
- ✅ Authentication Pages (Login, 2FA, Forgot/Reset Password)
- ✅ Role-based Routing
- ✅ Dashboard with Analytics
- ✅ Global Search Page
- ✅ Table Search with Pagination
- ✅ Reusable Components (Sidebar, Header, Footer, Button, Table)
- ✅ Responsive Design

## Requirements Met

✅ At least 5 entities (Doctor, Patient, Appointment, User, Location, Person, ActivityLog)
✅ At least 5 pages (Dashboard, Doctors, Patients, Appointments, Global Search, Users, Activity Logs, Profile)
✅ Dashboard with business information summary
✅ Pagination when displaying table data
✅ Password reset using email
✅ Two-factor authentication for login using email
✅ Global search functionality
✅ Table-level search by column values
✅ Role-based authentication (ADMIN, DOCTOR, PATIENT)
✅ Code reusability (one sidebar, one header, one footer, reusable buttons/tables)

## Setup

### Backend

1. Navigate to `clinic-system` directory
2. Update `application.properties` with your database credentials
3. Run the application:
```bash
mvn spring-boot:run
```

Backend runs on `http://localhost:8888`

### Frontend

1. Navigate to `frontend` directory
2. Install dependencies:
```bash
npm install
```

3. Start development server:
```bash
npm run dev
```

Frontend runs on `http://localhost:5173`

## API Endpoints

### Authentication
- `POST /auth/login/2fa` - Login with 2FA
- `POST /auth/verify-2fa` - Verify 2FA OTP
- `POST /auth/password-reset/request` - Request password reset
- `POST /auth/password-reset` - Reset password

### Dashboard
- `GET /api/dashboard/summary` - Get dashboard analytics (Admin only)

### Global Search
- `GET /api/search?query=<keyword>` - Global search

### Users (Admin only)
- `GET /api/users` - Get all users
- `POST /api/users` - Create user
- `PUT /api/users/{id}/role` - Update user role
- `PUT /api/users/{id}/status` - Update user status

### Activity Logs (Admin only)
- `GET /api/system/logs` - Get activity logs

## Roles

- **ADMIN**: Full system access, manages users, views all data
- **DOCTOR**: Views own appointments, patient data
- **PATIENT**: Views own profile and appointments

## Technologies

### Backend
- Spring Boot 3.5.7
- Spring Security + JWT
- PostgreSQL
- Spring Mail
- Thymeleaf (Email Templates)

### Frontend
- React 19
- Vite
- Tailwind CSS
- Axios
- React Router DOM


