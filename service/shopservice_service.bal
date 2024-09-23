import ballerina/grpc;

listener grpc:Listener ep = new (9090);

//Table to store books
table<ProductInfo> key(SKU) products = table [];

//Table to store users
table<User> key(user_id) users = table [];


@grpc:Descriptor {value: SHOP_DESC}
service "ShopService" on ep {

    remote function add_product(AddProductRequest value) returns AddProductResponse|error {
    
    //Define the new book
        ProductInfo product = {
            name: value.name,
            description: value.description,
            price: value.price,
            stkQuantity: value.stkQuantity,
            SKU: value.SKU,
            available: true // New book is available
        };

        // Add the book to the table
        _ = products.add(product);

        return {SKU: value.SKU};

    }
    remote function update_product(UpdateProductRequest value) returns UpdateProductResponse|error {
         // Find the book to update based on the provided ISBN
        ProductInfo|error productToBeUpdated = products.get(value.SKU);

        if (productToBeUpdated is error) {
            return error("Product not found");
        }

        // Create a BookInfo record with the updated values
        ProductInfo updatedBook = {
            name: value.name,
            description: value.description,
            price: value.price,
            stkQuantity: value.stkQuantity,
            SKU: value.SKU,
            available: productToBeUpdated.available // Preserve the availability status
        };

        // Update the book entry with the new values
        products.put(updatedBook);

        return {message: "Product updated successfully."};

    }
}