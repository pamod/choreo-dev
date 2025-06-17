package main

import (
	"encoding/json"
	"fmt"
	"log"
	"math/rand"
	"net/http"
	"regexp"
	"time"
	"unicode" // Added for character type checking
)

// init function is called before main() and is used to seed the random number generator
func init() {
	rand.Seed(time.Now().UnixNano())
}

// generateRandomDecimal generates a random decimal value between min and max (inclusive)
func generateRandomDecimal(min, max float64) float64 {
	// Generate a random float64 between 0.0 and 1.0
	randomFloat := rand.Float64()
	// Scale and shift to the desired range
	return min + randomFloat*(max-min)
}

// billHandler handles HTTP requests to /bill/users/{userId}
func billHandler(w http.ResponseWriter, r *http.Request) {
	// Only allow GET requests
	if r.Method != http.MethodGet {
		http.Error(w, "Method not allowed", http.StatusMethodNotAllowed)
		return
	}

	// Extract userId from the URL path.
	// Updated regex to capture ANY string after /bill/users/
	path := r.URL.Path
	re := regexp.MustCompile(`/bill/users/(.+)$`) // (.+) captures one or more of any characters
	matches := re.FindStringSubmatch(path)

	if len(matches) < 2 {
		log.Printf("Invalid URL path format: %s", path)
		http.Error(w, "Invalid URL format. Expected /bill/users/{anyString}", http.StatusBadRequest)
		return
	}
	userID := matches[1]

	log.Printf("Received request for user ID: %s", userID)

	// Prepare a generic map for the JSON response
	response := make(map[string]interface{})

	// Check the first character of the userID
	if len(userID) == 0 {
		log.Printf("Empty user ID provided.")
		http.Error(w, "User ID cannot be empty.", http.StatusBadRequest)
		return
	}

	firstChar := rune(userID[0]) // Get the first character as a rune for Unicode handling

	if unicode.IsDigit(firstChar) {
		// Starting character is a digit: return due amount
		dueAmount := generateRandomDecimal(10.0, 500.0)
		formattedDueAmount := fmt.Sprintf("$%.2f", dueAmount)
		response["dueAmount"] = formattedDueAmount
		log.Printf("Returning mock bill for user %s (starts with digit): %s", userID, formattedDueAmount)
	} else if unicode.IsLetter(firstChar) {
		// Starting character is an alpha character: return "No due to pay" message
		response["message"] = "No due to pay"
		log.Printf("Returning message for user %s (starts with letter): No due to pay", userID)
	} else {
		// Starting character is neither a digit nor an alpha character (e.g., symbol)
		log.Printf("User ID %s starts with an unsupported character: %c", userID, firstChar)
		http.Error(w, "Invalid user ID. Must start with a digit or an alphabetical character.", http.StatusBadRequest)
		return
	}

	// Set the Content-Type header to application/json
	w.Header().Set("Content-Type", "application/json")

	// Encode the response object to JSON and write it to the response writer
	if err := json.NewEncoder(w).Encode(response); err != nil {
		log.Printf("Error encoding JSON response: %v", err)
		http.Error(w, "Internal server error", http.StatusInternalServerError)
		return
	}
}

func main() {
	// Register the handler function for the /bill/users/ path.
	http.HandleFunc("/bill/users/", billHandler)

	// Start the HTTP server on port 8080
	port := ":8080"
	log.Printf("Starting HTTP service on port %s", port)
	log.Fatal(http.ListenAndServe(port, nil))
}
