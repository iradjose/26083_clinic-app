#!/bin/bash

# Clinic Management System API Test Script
# Make sure the backend is running on http://localhost:8888
# You need to get a JWT token first by logging in

BASE_URL="http://localhost:8888"
ADMIN_EMAIL="hacksergeb@gmail.com"
ADMIN_PASSWORD="654321"

echo "=========================================="
echo "Clinic Management System API Tests"
echo "=========================================="
echo ""

# Step 1: Login to get JWT token
echo "1. Testing Login..."
LOGIN_RESPONSE=$(curl -s -X POST "$BASE_URL/auth/login" \
  -H "Content-Type: application/json" \
  -d "{\"email\":\"$ADMIN_EMAIL\",\"password\":\"$ADMIN_PASSWORD\"}")

echo "Login Response: $LOGIN_RESPONSE"
TOKEN=$(echo $LOGIN_RESPONSE | grep -o '"accessToken":"[^"]*' | cut -d'"' -f4)

if [ -z "$TOKEN" ]; then
  echo "ERROR: Failed to get token. Please check credentials."
  exit 1
fi

echo "Token obtained: ${TOKEN:0:50}..."
echo ""

# Step 2: Test Dashboard Summary
echo "2. Testing Dashboard Summary..."
curl -s -X GET "$BASE_URL/api/dashboard/summary" \
  -H "Authorization: Bearer $TOKEN" | jq '.'
echo ""

# Step 3: Test Get All Patients
echo "3. Testing Get All Patients..."
curl -s -X GET "$BASE_URL/api/patients?page=0&size=10" \
  -H "Authorization: Bearer $TOKEN" | jq '.content | length'
echo ""

# Step 4: Test Get All Doctors
echo "4. Testing Get All Doctors..."
curl -s -X GET "$BASE_URL/api/doctors?page=0&size=10" \
  -H "Authorization: Bearer $TOKEN" | jq '.content | length'
echo ""

# Step 5: Test Get All Appointments
echo "5. Testing Get All Appointments..."
curl -s -X GET "$BASE_URL/api/appointments?page=0&size=10" \
  -H "Authorization: Bearer $TOKEN" | jq '.content | length'
echo ""

# Step 6: Test Get All Users
echo "6. Testing Get All Users..."
curl -s -X GET "$BASE_URL/api/users?page=0&size=10" \
  -H "Authorization: Bearer $TOKEN" | jq '.content | length'
echo ""

# Step 7: Test Get Activity Logs
echo "7. Testing Get Activity Logs..."
curl -s -X GET "$BASE_URL/api/system/logs?page=0&size=20" \
  -H "Authorization: Bearer $TOKEN" | jq '.data.content | length'
echo ""

# Step 8: Test Create Patient
echo "8. Testing Create Patient..."
CREATE_PATIENT_RESPONSE=$(curl -s -X POST "$BASE_URL/admin/create-patient" \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Test Patient",
    "email": "testpatient@test.com",
    "phone": "+250788999999",
    "gender": "Male",
    "dob": "1990-01-01",
    "locationId": 1
  }')
echo "Create Patient Response: $CREATE_PATIENT_RESPONSE"
echo ""

# Step 9: Test Create Doctor
echo "9. Testing Create Doctor..."
CREATE_DOCTOR_RESPONSE=$(curl -s -X POST "$BASE_URL/admin/create-doctor" \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Dr. Test Doctor",
    "email": "testdoctor@test.com",
    "phone": "+250788888888",
    "specialization": "General Medicine",
    "locationId": 1
  }')
echo "Create Doctor Response: $CREATE_DOCTOR_RESPONSE"
echo ""

# Step 10: Test Create User
echo "10. Testing Create User..."
CREATE_USER_RESPONSE=$(curl -s -X POST "$BASE_URL/api/users" \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "email": "testuser@test.com",
    "role": "PATIENT"
  }')
echo "Create User Response: $CREATE_USER_RESPONSE"
echo ""

# Step 11: Test Get Locations Hierarchy
echo "11. Testing Get Locations Hierarchy..."
curl -s -X GET "$BASE_URL/api/locations/hierarchy" \
  -H "Authorization: Bearer $TOKEN" | jq '.[0].name'
echo ""

echo "=========================================="
echo "All tests completed!"
echo "=========================================="

