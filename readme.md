# 🚆 Railway Reservation Management System  

## 📌 Overview  
This project is a **Railway Reservation Management System** built with **Flask, SQL, and HTML templates**.  
It allows users to:  
- Input SQL queries through a web interface.  
- Execute queries against a predefined railway database schema.  
- View results in a clean, styled HTML table.  
- Generate synthetic datasets for testing and analysis.  

---

## 📂 Folder Structure  

```
Website_code/
│── Templates/
│   ├── index.html         # Query input page
│   ├── results.html       # Results display page
│
│── app.py                 # Flask backend server
│── create.sql             # Database schema (tables + relationships)
│── data_generation.py     # Script to generate sample datasets (CSV)
│── readme.md              # Project documentation (this file)
│── .DS_Store              # System file (can be ignored)
```

---

## ⚙️ Features  

- **Database Schema**: Users, Passengers, Stations, Trains, Tickets, Payments, Insurance, Feedback, Cancellations, Schedules.  
- **Web Application**:  
  - `index.html`: Enter SQL queries.  
  - `results.html`: Display results in table format.  
- **Data Generator**: Create synthetic CSV datasets for all tables.  

---

## 🛠 Setup Instructions  

### 1. Clone the Repository  
```bash
git clone <your-repo-url>
cd Website_code
```

### 2. Install Dependencies  
Ensure **Python 3.x** is installed.  
```bash
pip install flask pandas numpy
```

### 3. Set up the Database  
Run the SQL schema in your MySQL/PostgreSQL/SQLite environment:  
```sql
source create.sql;
```

### 4. Generate Sample Data (Optional)  
Run the Python script to generate CSV datasets:  
```bash
python data_generation.py
```

### 5. Run the Application  
Start the Flask app:  
```bash
python app.py
```

The app will run on:  
👉 `http://127.0.0.1:5000/`  

---

## 🚀 Usage  

1. Open the app in your browser.  
2. Enter an SQL query (example: `SELECT * FROM users;`).  
3. Submit the query.  
4. Results will be displayed in a formatted table.  

---

## 📊 Example Queries  

- Fetch all trains:  
  ```sql
  SELECT * FROM train;
  ```  

- Get tickets booked by a user:  
  ```sql
  SELECT * FROM ticket WHERE user_id = 1;
  ```  

- List all stations:  
  ```sql
  SELECT * FROM railway_station;
  ```  

---

## 📝 Notes  

- Data types and constraints (e.g., seat types, booking status) are enforced in `create.sql`.  
- `data_generation.py` lets you adjust the number of generated records.  
- `.DS_Store` can be ignored in version control (`.gitignore`).  

