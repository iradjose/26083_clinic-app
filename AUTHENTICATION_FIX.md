# Authentication Fix - How to Use the Application

## Issue
The frontend is getting 403 Forbidden errors because the user is not logged in or the token is not being sent.

## Solution
**You must log in first before accessing any admin pages.**

### Steps to Fix:

1. **Start the Backend Server**
   ```bash
   cd clinic-system
   mvn spring-boot:run
   ```
   Backend should run on `http://localhost:8888`

2. **Start the Frontend Server**
   ```bash
   cd frontend
   npm run dev
   ```
   Frontend should run on `http://localhost:5173` (or similar)

3. **Log In as Admin**
   - Navigate to `http://localhost:5173/login`
   - Use these credentials:
     - Email: `hacksergeb@gmail.com`
     - Password: `654321`
   - Complete 2FA verification if prompted
   - You will be redirected to `/admin/dashboard`

4. **Verify Token is Stored**
   - Open browser DevTools (F12)
   - Go to Application/Storage > Local Storage
   - Check that `accessToken` is present

5. **Now You Can Access Admin Pages**
   - Dashboard: `/admin/dashboard`
   - Doctors: `/admin/doctors`
   - Patients: `/admin/patients`
   - Appointments: `/admin/appointments`
   - Users: `/admin/users`
   - Activity Logs: `/admin/logs`

## What Was Fixed

1. **Axios Client** - Added better 403 error handling and token verification
2. **Dashboard** - Added authentication check before fetching data
3. **All Admin Pages** - Protected by RoleGuard to ensure only ADMIN users can access
4. **Token Interceptor** - Ensures token is sent with all requests

## Testing

After logging in, all API calls should work:
- Dashboard summary: `GET /api/dashboard/summary`
- Get patients: `GET /api/patients?page=0&size=10`
- Get doctors: `GET /api/doctors?page=0&size=10`
- Get appointments: `GET /api/appointments?page=0&size=10`
- Get users: `GET /api/users?page=0&size=10`
- Get activity logs: `GET /api/system/logs?page=0&size=20`

## Backend Endpoints Fixed

1. **Create Doctor** - Fixed User-Doctor relationship
2. **Create User** - Already working
3. **Password Reset** - Fixed to use correct email service method

## Notes

- If you see 403 errors, make sure you're logged in
- If token expires, you'll be redirected to login
- All admin endpoints require ADMIN role
- Token is automatically sent with all requests via axios interceptor

