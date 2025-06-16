## You will find a demo video which shows how to use it in root folder named demo.mp4

# E-Commerce Platform

This project is a full-stack e-commerce application designed to allow customers to browse products, add them to a cart and wishlist, and place orders. Sellers can manage their products, view sales data, and track orders.

## Overview

The application is composed of two main components:

- **Backend:** A Node.js/Express application responsible for the API, business logic, and database interactions. (Likely uses MongoDB as the database).
- **Frontend:** A Next.js/React application providing the user interface for customers and sellers.

The entire application is containerized using Docker for ease of setup and deployment.

## Backend

The backend is built with Node.js and Express. It serves as the API for the frontend, handles all business logic, manages user authentication, and interacts with the database (presumed to be MongoDB).

Key responsibilities include:

- User registration and login
- Product management (creating, updating, deleting, listing products by sellers)
- Shopping cart and wishlist functionalities
- Order processing and management
- Dashboard data aggregation for both customers and sellers

For detailed API documentation, please refer to the [Backend README](./backend/README.md).

## Frontend

The frontend is a Next.js (React) application that provides a dynamic and responsive user interface for both customers and sellers.

Key features include:

- User-friendly interface for browsing products, managing cart and wishlist.
- Customer dashboard for viewing order history, managing addresses, and tracking active orders.
- Seller dashboard for product management, order fulfillment, and viewing sales analytics.
- Secure registration and login forms.
- Checkout process.

The frontend interacts with the backend via RESTful API calls to fetch and display data, as well as to perform user actions.

## Running the Application

The application is designed to be run using Docker and Docker Compose.

### Prerequisites

- Docker: Make sure you have Docker installed on your system.
- Docker Compose: Make sure you have Docker Compose installed.

### Setup

1.  **Clone the repository:**

    ```bash
    git clone <repository-url>
    cd <repository-folder>
    ```

2.  **Environment Variables (Backend):**
    The backend service requires environment variables to be set. There is an existing `.env` file at `backend/.env`. You may need to review and adjust this file, or create it if it's not included in the clone (e.g., if it's in `.gitignore`). Common variables include:

    - `MONGO_URI`: MongoDB connection string.
    - `JWT_SECRET`: Secret key for JWT token generation.
    - `PORT`: Port for the backend server (e.g., 5000).

    Ensure the `backend/.env` file is correctly configured before starting the application.

3.  **Environment Variables (Frontend):**
    The frontend may also require environment variables, typically for connecting to the backend API. These would usually be prefixed with `NEXT_PUBLIC_`. For example:

    - `NEXT_PUBLIC_API_URL=http://localhost:5000/api` (if your backend runs on port 5000)
    - `NEXT_PUBLIC_BACKEND_BASE_URL=http://127.0.0.1:5000`

    These might be set directly in the `docker-compose.yml` or require a `.env.local` file in the `frontend` directory. Check the `frontend/Dockerfile` and `docker-compose.yml` for specifics.

### Starting the Application

Once the environment variables are configured, you can start the application using Docker Compose:

```bash
docker compose up -d
```

This command will build the images (if not already built) and start the frontend and backend services in detached mode.

- The frontend should typically be accessible at `http://localhost:3000` (or the port specified in `docker-compose.yml`).
- The backend API will be running on its configured port (e.g., `http://localhost:5000`).

### Stopping the Application

To stop the application:

```bash
docker compose down
```

# Features I have implemented

1. Authentication and Authorization using JWT.
2. User can create account using 2 roles. `Customer` and `Seller`.
3. `Seller` user has access to: Adding and managing new products, Managing orders and he can also act as a `Customer`.
4. Also implemented detailed dashboard for both `Seller` and `Customer`
5. `Customer` and `Seller` can add items in the wishlist, add items in the cart and can also order an item.
6. User can track his/her order. `Seller` can update order status.
7. User can cancel order with cancellation reason (optional).
8. Detailed dashboard for `Seller`.
9. While uploading new product, user can build their own custom form. Like user can create 5 input box, 2 textarea for a particular product.

# Assumptions made due to incomplete designs

I didn't have any idea about how the order status update UI will look like. I went throught some design in dribble and behance and tried to take some idea from multiple design.
Profile page uses shadcn tabs in figma design. I tried to render all the section in one page as handling with tabs making it more complex to handle for each section.

I think rest of the features was already given in the figma file.

# Challenges faced during development

1. Man, the hardest part was handling the order. I am sure, I didn't do it properly. My initial goal was try to implement stripe for payment. It was becoming more complex so i took a shortcut - replace Stripe with COD. I had to take help from ChatGPT for implementing the order backend code as i was confused how to track the order, update the status and cancel the order with proper reason.

2. While creating the product form, i realized product category can be anything. And the input field in specification field can also vary according to the product. So rendering some static form won't help user to showcase product details. So, i got an idea. What if i create a form component that let's user choose his own input form with custom label. So that he can describe the product details more easily.

3. One reusable DataTable component for every list. Learned to use generics and pass specific action buttons for specific components.

4. Not a typescript pro, so handling all the types was kinda difficult.

# Missing design elements or instructions you would need to complete the task more accurately

1. Didn't implement Payment feature Seller.
2. I think, order functionality has many bugs. It needs much improvement.
3. Some of actions like `Ship order`, `Buy again`, `Reorder` etc doesn't work currently. It will be a great user experience if these small features can be implemented.
