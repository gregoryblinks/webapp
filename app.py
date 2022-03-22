from app import create_app, cursor, connection

app = create_app()

if __name__ == '__main__':
    app.run(debug=True)

cursor.close()
connection.close()
print("Database closed successfully")
