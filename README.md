# Currency Exchange App

## Overview
The **Currency Exchange App** allows users to convert between different currencies, view historical conversions, and see a summary of exchange details. It fetches real-time exchange rates from the ExchangeRate API and provides a user-friendly interface.

## Supported Currencies
The app supports the following currencies:
- **USD** (United States Dollar)
- **MYR** (Malaysian Ringgit)
- **VND** (Vietnamese Dong)
- **MMK** (Myanmar Kyat)
- **IDR** (Indonesian Rupiah)

## API Endpoint
The app uses the [ExchangeRate API](https://api.exchangerate-api.com) for real-time currency data:
- Base URL: `https://api.exchangerate-api.com/v4/latest/{currency}`

Example: `https://api.exchangerate-api.com/v4/latest/USD`

---

## Features
![Simulator Screenshot - iPhone 16 Pro - 2025-01-17 at 11 41 24](https://github.com/user-attachments/assets/5526f2f5-acc3-42bd-ad41-b7e524aab7cd)
![Simulator Screenshot - iPhone 16 Pro - 2025-01-17 at 11 41 18](https://github.com/user-attachments/assets/511f662e-409b-4750-9d8e-8355ba9c99b7)
![Simulator Screenshot - iPhone 16 Pro - 2025-01-17 at 11 41 12](https://github.com/user-attachments/assets/b8d245a9-c00f-49ba-bf0c-ecd4f654bd2a)
![Simulator Screenshot - iPhone 16 Pro - 2025-01-17 at 11 41 05](https://github.com/user-attachments/assets/3b10079e-0ffd-4c99-a096-387806c7f4fa)
![Simulator Screenshot - iPhone 16 Pro - 2025-01-17 at 11 42 28](https://github.com/user-attachments/assets/3208d7a4-5d2e-4f9b-9f9a-0dd19d9e1fd7)

### 1. Source Currency List
- Displays a list of available source currencies with flags and currency names.
- Includes a button to navigate to the **Historical Conversions** screen.
- Historical Conversions:
  - Shows the last 10 conversions, including:
    - Source amount
    - Destination amount
    - Exchange rate
  - Allows navigation back to the conversion screen with pre-filled values.

### 2. Destination Currency List
- Displays destination currencies in a similar format to the source currency list.
- Shows the exchange rate as a **subtitle** for each currency.
- Handles API errors and displays them in a **bottom sheet**.

### 3. Currency Conversion
- Real-time conversion between selected currencies.
- Automatically updates the destination field when inputting an amount in the source currency field, and vice versa.
- Displays error messages in **red** if the input is below the minimum amount of `10`.
- Includes a button to navigate to the **Summary View**.

### 4. Summary View
- Displays:
  - The **currency rate** used for conversion.
  - The **total amount** after conversion for each currency.
- Includes two buttons:
  1. **Save & Share**: Saves the summary as an image and opens a sharing sheet.
  2. **Go to Home Screen**: Returns to the main screen.

### 5. Error Handling
- **Network Failures**: Shows a bottom sheet with a retry option.
- **Invalid API Responses**: Displays a user-friendly error message.

### 6. Unit Test Coverage
- Achieves **80% unit test coverage** for critical functionalities, including:
  - Currency conversion logic.
  - API error handling.
  - Minimum input validation.

---

## Deliverables

### Source Code
The complete source code is available in this repository.

### README
This README file includes:
- App functionality overview.
- API usage details.
- Setup instructions.

### Unit Tests
Unit tests cover:
- Currency conversion logic.
- Error handling.
- Validation rules for input fields.

### Error Handling
Demonstrates how the app handles:
- Network failures.
- Invalid API responses.

---

## Setup Instructions

### Prerequisites
- **Xcode**: Version 13.0 or later.
- **iOS**: Version 15.0 or later.
- An active internet connection to fetch real-time exchange rates.

### Steps to Run
1. Clone the repository:
   ```bash
   git clone https://github.com/LM-mm98/CurrencyExchange.git
