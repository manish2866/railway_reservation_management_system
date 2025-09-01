How the datasets were generated:

# In[6]:


import pandas as pd
import numpy as np
import uuid
from datetime import datetime, timedelta

# Helper functions
def random_string(prefix="", length=10):
        """Generate a random string of fixed length."""
        letters = list('abcdefghijklmnopqrstuvwxyz')
        return prefix + ''.join(np.random.choice(letters, size=length))

def random_phone_number():
        """Generate a random 10-digit phone number."""
        return np.random.randint(1000, 9999)

def random_email(name):
        """Generate a random email based on name."""
        domains = ['example.com', 'test.com', 'demo.com']
        return f"{name.lower().replace(' ', '.')}@{np.random.choice(domains)}"

def random_date(start_year=2020, end_year=2024):
        """Generate a random date within a range and return it in 'yyyy-mm-dd' format."""
        start_date = datetime(year=start_year, month=1, day=1)
        end_date = datetime(year=end_year, month=12, day=31)
        random_date = np.random.choice(pd.date_range(start_date, end_date))
        # Convert numpy.datetime64 to datetime.datetime
        random_date = pd.to_datetime(random_date).to_pydatetime()
        return random_date.strftime('%Y-%m-%d')

def random_time():
        """Generate a random time."""
        hour = np.random.randint(0, 24)
        minute = np.random.randint(0, 60)
        second = np.random.randint(0, 60)
        return f"{hour:02}:{minute:02}:{second:02}"

# Generating data for Users
num_users = 4000
users = pd.DataFrame({
        'user_id': np.arange(1, num_users + 1),
        'username': [random_string('user', 5) for _ in range(num_users)],
        'email_id': [random_email(random_string()) for _ in range(num_users)],
        'user_age': np.random.randint(18, 70, num_users),
        'mobile_no': [random_phone_number() for _ in range(num_users)]
})

# Generating data for Passengers
num_passengers = 8000
passengers = pd.DataFrame({
        'passenger_id': np.arange(1, num_passengers + 1),
        'passenger_name': [random_string('passenger', 5) for _ in range(num_passengers)],
        'passenger_age': np.random.randint(1, 100, num_passengers),
        'user_id': np.random.choice(users['user_id'], num_passengers)
})

# Generating data for Railway Stations
num_stations = 50
railway_stations = pd.DataFrame({
        'station_code': np.arange(1, num_stations + 1),
        'station_name': [random_string('station', 5) for _ in range(num_stations)],
        'city': [random_string('city', 5) for _ in range(num_stations)],
        'state': [random_string('state', 5) for _ in range(num_stations)]
})

# Generating data for Trains
num_trains = 30
trains = pd.DataFrame({
        'train_no': np.arange(1, num_trains + 1),
        'train_name': [random_string('train', 5) for _ in range(num_trains)],
        'source_station_code': np.random.choice(railway_stations['station_code'], num_trains),
        'dest_station_code': np.random.choice(railway_stations['station_code'], num_trains),
        'total_seats': np.random.randint(50, 500, num_trains),
        'working_days': ['Mon-Fri' for _ in range(num_trains)]    # Simplified for the example
})

# Generating data for Tickets
num_tickets = 6000
tickets = pd.DataFrame({
        'pnr_num': np.arange(1, num_tickets + 1),
        'source_station_code': np.random.choice(trains['source_station_code'], num_tickets),
        'dest_station_code': np.random.choice(trains['dest_station_code'], num_tickets),
        'train_no': np.random.choice(trains['train_no'], num_tickets),
        'user_id': np.random.choice(users['user_id'], num_tickets),
        'date_travel': [random_date() for _ in range(num_tickets)],
        'passenger_id': np.random.choice(passengers['passenger_id'], num_tickets),
        'seat_type': np.random.choice(['Economy', 'Business', 'FirstClass'], num_tickets),
        'booking_status': np.random.choice(['Confirmed', 'Waiting', 'Cancelled'], num_tickets),
        'booking_time': [random_date() for _ in range(num_tickets)]
})

# Generating data for Insurance
num_insurances = 8000
insurances = pd.DataFrame({
        'insurance_id': np.arange(1, num_insurances + 1),
        'passenger_id': np.random.choice(passengers['passenger_id'], num_insurances),
        'insurance_coverage': np.random.uniform(1000.0, 10000.0, num_insurances)
})

# Generating data for Feedback
num_feedbacks = 6000
feedbacks = pd.DataFrame({
        'feedback_id': np.arange(1, num_feedbacks + 1),
        'rating': np.random.randint(1, 6, num_feedbacks),    # Assuming a scale from 1 to 5
        'pnr_num': np.random.choice(tickets['pnr_num'], num_feedbacks),
        'user_id': np.random.choice(users['user_id'], num_feedbacks)
})

# Generating data for Payment
num_payments = 6000
payments = pd.DataFrame({
        'payment_id': np.arange(1, num_payments + 1),
        'pnr_num': np.random.choice(tickets['pnr_num'], num_payments),
        'ticket_fare': np.random.uniform(50.0, 500.0, num_payments).round(2),
        'payment_date': [random_date() for _ in range(num_payments)]
})

# Generating data for Cancellation
num_cancellations = 1000
cancellations = pd.DataFrame({
        'cancellation_id': np.arange(1, num_cancellations + 1),
        'pnr_num': np.random.choice(tickets['pnr_num'], num_cancellations),
        'cancellation_date': [random_date() for _ in range(num_cancellations)],
        'refund_amount': np.random.uniform(10.0, 300.0, num_cancellations).round(2)
})

# Generating data for Schedule
num_schedules = 500
schedules = pd.DataFrame({
        'schedule_id': np.arange(1, num_schedules + 1),
        'train_no': np.random.choice(trains['train_no'], num_schedules),
        'curr_station_code': np.random.choice(railway_stations['station_code'], num_schedules),
        'next_station_code': np.random.choice(railway_stations['station_code'], num_schedules),
        'arr_time': [random_time() for _ in range(num_schedules)],
        'dep_time': [random_time() for _ in range(num_schedules)]
})

# Ensure departure time is later than or equal to arrival time for the Schedule table
for index, row in schedules.iterrows():
        if row['dep_time'] <= row['arr_time']:
                schedules.at[index, 'dep_time'] = (datetime.strptime(row['arr_time'], '%H:%M:%S') + timedelta(minutes=30)).time().strftime('%H:%M:%S')

cancellations.to_csv('/Users/manish/Desktop/cancellations.csv', index=False)
users.to_csv('/Users/manish/Desktop/Users.csv', index=False)
passengers.to_csv('/Users/manish/Desktop/Passengers.csv', index=False)
railway_stations.to_csv('/Users/manish/Desktop/Railway_Stations.csv', index=False)
trains.to_csv('/Users/manish/Desktop/Trains.csv', index=False)
tickets.to_csv('/Users/manish/Desktop/Tickets.csv', index=False)
insurances.to_csv('/Users/manish/Desktop/Insurances.csv', index=False)
feedbacks.to_csv('/Users/manish/Desktop/Feedbacks.csv', index=False)
payments.to_csv('/Users/manish/Desktop/Payments.csv', index=False)
schedules.to_csv('/Users/manish/Desktop/Schedules.csv', index=False)


print("CSV files generated for all tables.")


# In[ ]:


1. By running the above code in Jupyter notebook and by changing the no of records in each table different datasets can be generated


Instructions to use the website

1. Run the app.py file in any IDE
2. After running the file, it will open in the default browser.
3. Create an SQL query for the railway management system database
4. Execute the query
5. Results are opened
