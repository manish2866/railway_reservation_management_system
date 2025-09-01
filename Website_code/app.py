from flask import Flask, render_template, request
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import text  # Import the text function

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://postgres:pranav123@localhost/RailwayReservationManagementSystem'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db = SQLAlchemy(app)

@app.route('/', methods=['GET', 'POST'])
def index():
    if request.method == 'POST':
        query = request.form['query']
        print(f"Received query: {query}")  # Debugging statement
        try:
            # Start a new database session
            session = db.session()
            query_text = text(query)
            # Execute the query
            results = session.execute(query_text)
            # Fetch all results
            columns = results.keys()
            results = results.fetchall()
            # Close the session
            session.close()
            print(f"Results: {results}")  # Debugging statement
            print(f"Columns: {columns}")  # Debugging statement
            return render_template('results.html', results=results, columns=columns)
        except Exception as e:
            return f"An error occurred: {e}"
    return render_template('index.html')

@app.route('/test_db_connection')
def test_db_connection():
    try:
        # Attempt to fetch the current time from the database
        session = db.session()
        query = text('SELECT NOW()')  # Declare the SQL query as text
        result = session.execute(query)
        current_time = result.fetchone()[0]
        # Close the session
        session.close()
        return f"Database connection successful. Current server time: {current_time}"
    except Exception as e:
        return f"Failed to connect to the database: {e}"

if __name__ == '__main__':
    app.run(debug=True)
