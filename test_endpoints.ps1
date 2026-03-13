# Clinic Management System API Test Script (PowerShell)
# Make sure the backend is running on http://localhost:8888

$BaseUrl = "http://localhost:8888"
$AdminEmail = "hacksergeb@gmail.com"
$AdminPassword = "654321"

Write-Host "=========================================="
Write-Host "Clinic Management System API Tests"
Write-Host "=========================================="
Write-Host ""

# Step 1: Login to get JWT token
Write-Host "1. Testing Login..."
$LoginBody = @{
    email = $AdminEmail
    password = $AdminPassword
} | ConvertTo-Json

$LoginResponse = Invoke-RestMethod -Uri "$BaseUrl/auth/login" -Method Post -Body $LoginBody -ContentType "application/json"
$Token = $LoginResponse.accessToken

if (-not $Token) {
    Write-Host "ERROR: Failed to get token. Please check credentials."
    exit 1
}

Write-Host "Token obtained: $($Token.Substring(0, [Math]::Min(50, $Token.Length)))..."
Write-Host ""

$Headers = @{
    "Authorization" = "Bearer $Token"
    "Content-Type" = "application/json"
}

# Step 2: Test Dashboard Summary
Write-Host "2. Testing Dashboard Summary..."
$DashboardResponse = Invoke-RestMethod -Uri "$BaseUrl/api/dashboard/summary" -Method Get -Headers $Headers
Write-Host "Dashboard Data: $($DashboardResponse | ConvertTo-Json -Depth 3)"
Write-Host ""

# Step 3: Test Get All Patients
Write-Host "3. Testing Get All Patients..."
$PatientsResponse = Invoke-RestMethod -Uri "$BaseUrl/api/patients?page=0&size=10" -Method Get -Headers $Headers
Write-Host "Patients Count: $($PatientsResponse.content.Count)"
Write-Host ""

# Step 4: Test Get All Doctors
Write-Host "4. Testing Get All Doctors..."
$DoctorsResponse = Invoke-RestMethod -Uri "$BaseUrl/api/doctors?page=0&size=10" -Method Get -Headers $Headers
Write-Host "Doctors Count: $($DoctorsResponse.content.Count)"
Write-Host ""

# Step 5: Test Get All Appointments
Write-Host "5. Testing Get All Appointments..."
$AppointmentsResponse = Invoke-RestMethod -Uri "$BaseUrl/api/appointments?page=0&size=10" -Method Get -Headers $Headers
Write-Host "Appointments Count: $($AppointmentsResponse.content.Count)"
Write-Host ""

# Step 6: Test Get All Users
Write-Host "6. Testing Get All Users..."
$UsersResponse = Invoke-RestMethod -Uri "$BaseUrl/api/users?page=0&size=10" -Method Get -Headers $Headers
Write-Host "Users Count: $($UsersResponse.content.Count)"
Write-Host ""

# Step 7: Test Get Activity Logs
Write-Host "7. Testing Get Activity Logs..."
$LogsResponse = Invoke-RestMethod -Uri "$BaseUrl/api/system/logs?page=0&size=20" -Method Get -Headers $Headers
Write-Host "Logs Count: $($LogsResponse.data.content.Count)"
Write-Host ""

# Step 8: Test Create Patient
Write-Host "8. Testing Create Patient..."
$CreatePatientBody = @{
    name = "Test Patient"
    email = "testpatient@test.com"
    phone = "+250788999999"
    gender = "Male"
    dob = "1990-01-01"
    locationId = 1
} | ConvertTo-Json

try {
    $CreatePatientResponse = Invoke-RestMethod -Uri "$BaseUrl/admin/create-patient" -Method Post -Body $CreatePatientBody -Headers $Headers
    Write-Host "Create Patient Response: $($CreatePatientResponse | ConvertTo-Json)"
} catch {
    Write-Host "Error: $($_.Exception.Message)"
}
Write-Host ""

# Step 9: Test Create Doctor
Write-Host "9. Testing Create Doctor..."
$CreateDoctorBody = @{
    name = "Dr. Test Doctor"
    email = "testdoctor@test.com"
    phone = "+250788888888"
    specialization = "General Medicine"
    locationId = 1
} | ConvertTo-Json

try {
    $CreateDoctorResponse = Invoke-RestMethod -Uri "$BaseUrl/admin/create-doctor" -Method Post -Body $CreateDoctorBody -Headers $Headers
    Write-Host "Create Doctor Response: $($CreateDoctorResponse | ConvertTo-Json)"
} catch {
    Write-Host "Error: $($_.Exception.Message)"
}
Write-Host ""

# Step 10: Test Create User
Write-Host "10. Testing Create User..."
$CreateUserBody = @{
    email = "testuser@test.com"
    role = "PATIENT"
} | ConvertTo-Json

try {
    $CreateUserResponse = Invoke-RestMethod -Uri "$BaseUrl/api/users" -Method Post -Body $CreateUserBody -Headers $Headers
    Write-Host "Create User Response: $($CreateUserResponse | ConvertTo-Json)"
} catch {
    Write-Host "Error: $($_.Exception.Message)"
}
Write-Host ""

# Step 11: Test Get Locations Hierarchy
Write-Host "11. Testing Get Locations Hierarchy..."
$LocationsResponse = Invoke-RestMethod -Uri "$BaseUrl/api/locations/hierarchy" -Method Get -Headers $Headers
Write-Host "First Province: $($LocationsResponse[0].name)"
Write-Host ""

Write-Host "=========================================="
Write-Host "All tests completed!"
Write-Host "=========================================="

