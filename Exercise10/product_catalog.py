# product_catalog.py
import os
from flask import Flask, jsonify

app = Flask(__name__)

products = [
    {"id": 1, "name": "Laptop", "price": 1200},
    {"id": 2, "name": "Phone", "price": 800},
    {"id": 3, "name": "Headphones", "price": 150},
]

@app.route("/products", methods=["GET"])
def get_products():
    return jsonify(products)

if __name__ == "__main__":
    # PORT defaults to 80 (as in the manual); the env var lets us test locally without root
    app.run(host="0.0.0.0", port=int(os.environ.get("PORT", 80)))
