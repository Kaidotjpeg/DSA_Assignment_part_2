import ballerina/io;

ShopServiceClient ep = check new ("http://localhost:9090");

function getMenuChoice() returns string {
    io:println("Shop System Menu:");
    io:println("1. Create Users");
    io:println("2. Add Product");
    io:println("3. Update Product");
    io:println("4. List available products");
    io:println("5. Search Product");
    io:println("6. Remove Product");
    io:println("Enter 'q' to quit");

    string choice = io:readln("Enter your choice: ");
    return choice;
}

public function main() returns error? {

        while (true) {
        string choice = getMenuChoice();

        if (choice == "1") {
            // Create users
            CreateUserResponse?|error users = createUsers();
            if users is CreateUserResponse {
                string successMessage = users.message;
                io:println(successMessage);
            } else if users is () {
                io:println("Something...");
            } else {
                string errorMessage = users.message();
                io:println(errorMessage);
            }

        } else if (choice == "2") {
            // Add product
            AddProductResponse|error product = addproduct();
            if product is AddProductResponse {
                io:println("product successfully created");
                io:println("SKU: " +product.SKU);
            } else {
                string errorMessage = product.message();
                io:println(errorMessage);
            }
        } else if (choice == "3") {
            // Update product
            UpdateProductResponse|error product = updateProduct();
            if product is UpdateProductResponse {
                string successMessage = product.message;
                io:println(successMessage);
            } else {
                string errorMessage = product.message();
                io:println(errorMessage);
            }
        
        } else if (choice == "4") {
            // List all available products
            ListAvailableProductsResponse|error listAvailableproductsResult = listAvailableproducts();
            if listAvailableproductsResult is ListAvailableProductsResponse {
                io:println("_______________________________________");
                io:println("Available products:");

                foreach var product in listAvailableproductsResult.products {
                    io:println("SKU: "+ product.SKU);
                    io:println("Name: "+ product.name);
                    io:println("description: "+ product.description);
                    io:println("Location: "+ product.location);
                    io:println("Stock Quantity: "+ product.stkQuantity);

                    io:println("_______________________________________________");
                }
            } else {
                string errorMessage = listAvailableproductsResult.message();
                io:println(errorMessage);
            }
        }
        else if (choice == "5") {
            // Locate product
            SearchProductResponse|error searchProductResult = searchProduct();
            if searchProductResult is SearchProductResponse {
                string productLocation = searchProductResult.location;
                string productAvailability = "";
                if searchProductResult.available is true {
                    productAvailability = "Available"; 
                } else {
                    productAvailability = "Not Available";
                }

                io:println("product Location: "+productLocation);
                io:println("product Availability: "+productAvailability);
            }
            else {
                io:println(searchProductResult.stackTrace());
                io:println(searchProductResult.cause());
            }
        }

        else if (choice == "6") {
            // Remove product
            RemoveProductResponse|error removeproductResult = removeproduct();
            if removeproductResult is RemoveProductResponse {
                io:println("product succesfully removed");
                io:println("_______________________________________");
                io:println("Remaining products:");

                foreach var product in removeproductResult.products {
                    io:println("SKU: "+ product.SKU);
                    io:println("Name : "+ product.name);
                    io:println("Description: "+ product.description);
                    io:println("_______________________________________________");
                }
            } else {
                io:println(removeproductResult.stackTrace());
                io:println(removeproductResult.cause());
            }
        }
         else if (choice == "q") {
            // Quit the application
            break;
        } else {
            io:println("Invalid choice. Please try again.");
        }
    }
    // CreateUserRequest create_usersRequest = {user_id: "ballerina", user_type: CUSTOMER};
    // Create_usersStreamingClient create_usersStreamingClient = check ep->create_users();
    // check create_usersStreamingClient->sendCreateUserRequest(create_usersRequest);
    // check create_usersStreamingClient->complete();
    // CreateUserResponse? create_usersResponse = check create_usersStreamingClient->receiveCreateUserResponse();
    // io:println(create_usersResponse);

    // AddProductRequest add_productRequest = {name: "ballerina", : "ballerina", price: "ballerina", stkQuantity: "ballerina", SKU: "ballerina"};
    // AddProductResponse add_productResponse = check ep->add_product(add_productRequest);
    // io:println(add_productResponse);

    // UpdateroductRequest update_productRequest = {SKU: "ballerina", name: "ballerina", : "ballerina", price: "ballerina", stkQuantity: "ballerina"};
    // UpdateproductResponse update_productResponse = check ep->update_product(update_productRequest);
    // io:println(update_productResponse);

    // BorrowproductRequest borrow_productRequest = {user_id: "ballerina", SKU: "ballerina"};
    // BorrowproductResponse borrow_productResponse = check ep->borrow_product(borrow_productRequest);
    // io:println(borrow_productResponse);

    // ListBorrowedproductsRequest list_borrowed_productsRequest = {};
    // ListBorrowedproductsResponse list_borrowed_productsResponse = check ep->list_borrowed_products(list_borrowed_productsRequest);
    // io:println(list_borrowed_productsResponse);

    // ListAvailableproductsRequest list_available_productsRequest = {};
    // ListAvailableproductsResponse list_available_productsResponse = check ep->list_available_products(list_available_productsRequest);
    // io:println(list_available_productsResponse);

    // LocateproductRequest locate_productRequest = {SKU: "ballerina"};
    // LocateproductResponse locate_productResponse = check ep->locate_product(locate_productRequest);
    // io:println(locate_productResponse);

    // RemoveProductRequest remove_productRequest = {SKU: "ballerina"};
    // RemoveProductResponse remove_productResponse = check ep->remove_product(remove_productRequest);
    // io:println(remove_productResponse);
}
public function createUsers() returns CreateUserResponse?|error {
    // Create a streaming client to send user creation requests
    Create_usersStreamingClient create_usersStreamingClient = check ep->create_users();

    while (true) {
        // Interactively collect user input
        io:println("Enter user information:");
        string userId = io:readln("User ID: ");
        io:println("User Type (CUSTOMER/ADMIN): ");
        string userTypeInput = io:readln();
        
        UserType userType;
        if (userTypeInput == "CUSTOMER") {
            userType = CUSTOMER;
        } else if (userTypeInput == "ADMIN") {
            userType = ADMIN;
        } else {
            io:println("Invalid user type. Using default: CUSTOMER");
            userType = CUSTOMER;
        }

        // Create a CreateUserRequest
        CreateUserRequest createUserRequest = {
            user_id: userId,
            user_type: userType
        };

        // Send the CreateUserRequest to the server
        check create_usersStreamingClient->sendCreateUserRequest(createUserRequest);

        // Ask the user if they want to create another user
        io:println("Do you want to create another user? (yes/no): ");
        string continueInput = io:readln();

        if (continueInput != "yes") {
            break;
        }
    }

    // Complete the streaming client
    check create_usersStreamingClient->complete();

    // Receive the CreateUserResponse from the server
    CreateUserResponse? createUserResponse = check create_usersStreamingClient->receiveCreateUserResponse();

    return createUserResponse;
}

// Function to interactively collect product information for adding a product
function getproductInfoFromInput() returns AddProductRequest {
    io:println("Enter product information:");

    // Read product name from input
    string name = io:readln("Name: ");

    // Read product author(s) from input
    string Description = io:readln("description: ");
    string Price = io:readln("Price: ");

    // Read product stkQuantity from input
    string stkQuantity = io:readln();

    // Read product SKU from input
    string SKU = io:readln("SKU: ");

    AddProductRequest addProductRequest = {
        name: name,
        description: Description,
        price: Price,
        stkQuantity: stkQuantity,
        SKU: SKU
    };

    return addProductRequest;
}

// Function to add a product to the Shop
function addproduct() returns AddProductResponse|error {
    // Interactively collect product information
    AddProductRequest addProductRequest = getproductInfoFromInput();

    // Invoke the add_product gRPC function with the product information
    AddProductResponse|error AddProductResponse = ep->add_product(addProductRequest);

    return AddProductResponse;
}
function getUpdatedproductInfoFromInput() returns UpdateProductRequest {
    // Read product SKU from input
    string SKU = io:readln("Enter the SKU of the product to update: ");

    // Read updated product name from input
    string updatedname = io:readln("Updated Name: ");

    // Read updated product author(s) from input
    string updatedDescription = io:readln("Updated description: ");
    string updatedPrice = io:readln("Updated Price (optional, press Enter to skip): ");

    //Read updated Product stock quantity from input
    string updatedstkQuantity = io:readln("Updated Stock Quantity");
    
    UpdateProductRequest updateroductRequest = {
        SKU: SKU,
        name: updatedname,
        description: updatedDescription,
        price: updatedPrice,
        stkQuantity: updatedstkQuantity,      
        };

    return updateroductRequest;
}

// Function to update a product in the Shop
function updateProduct() returns UpdateProductResponse|error {
    // Interactively collect updated product information
    UpdateProductRequest updateroductRequest = getUpdatedproductInfoFromInput();

    // Invoke the update_product gRPC function with the updated product information
    UpdateProductResponse|error updateProductResponse = ep->update_product(updateroductRequest);

    return updateProductResponse;
}

// Function to interactively collect product information for removing a product
function getRemoveproductInfoFromInput() returns RemoveProductRequest {
    io:println("Enter product information to remove:");

    // Read product SKU from input
    string SKU = io:readln("Enter the SKU of the product to remove: ");

    RemoveProductRequest removeProductRequest = {
        SKU: SKU
    };

    return removeProductRequest;
}

// Function to remove a product from the Shop
function removeproduct() returns RemoveProductResponse|error {
    // Interactively collect product information to remove
    RemoveProductRequest removeProductRequest = getRemoveproductInfoFromInput();

    // Invoke the remove_product gRPC function with the product information to remove
    RemoveProductResponse|error removeProductResponse = ep->remove_product(removeProductRequest);

    return removeProductResponse;
}

// Function to interactively collect product SKU for locating a product
function getproductSKUForLocateFromInput() returns SearchProductRequest {
    // Read product SKU from input
    string SKU = io:readln("Enter the SKU of the product to locate: ");

    SearchProductRequest searchProductRequest = {
        SKU: SKU
    };

    return searchProductRequest;
}

// Function to locate a product in the Shop based on SKU
function searchProduct() returns SearchProductResponse|error {
    // Interactively collect product SKU to locate
    SearchProductRequest locateproductRequest = getproductSKUForLocateFromInput();

    // Invoke the locate_product gRPC function with the product SKU
    SearchProductResponse|error searchProductResponse = check ep->search_product(locateproductRequest);

    return searchProductResponse;
}


// Function to list all available products in the Shop
function listAvailableproducts() returns ListAvailableProductsResponse|error {
    // Create an empty request for listing available products
    ListAvailableProductsRequest listAvailableproductsRequest = {};

    // Invoke the list_available_products gRPC function to get the list of available products
    ListAvailableProductsResponse|error listAvailableproductsResponse = ep->list_available_products(listAvailableproductsRequest);

    return listAvailableproductsResponse;
}
