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
