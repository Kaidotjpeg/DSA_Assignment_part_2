import ballerina/grpc;
import ballerina/protobuf;

public const string SHOP_DESC = "0A0A53686F702E70726F746F120473686F702293010A1141646450726F647563745265717565737412120A046E616D6518012001280952046E616D6512200A0B6465736372697074696F6E180220012809520B6465736372697074696F6E12140A0570726963651803200128095205707269636512200A0B73746B5175616E74697479180420012805520B73746B5175616E7469747912100A03534B551805200128095203534B5522260A1241646450726F64756374526573706F6E736512100A03534B551801200128095203534B552296010A1455706461746550726F647563745265717565737412100A03534B551801200128095203534B5512120A046E616D6518022001280952046E616D6512200A0B6465736372697074696F6E180320012809520B6465736372697074696F6E12140A0570726963651804200128095205707269636512200A0B73746B5175616E74697479180520012805520B73746B5175616E7469747922310A1555706461746550726F64756374526573706F6E736512180A076D65737361676518012001280952076D65737361676522280A1452656D6F766550726F647563745265717565737412100A03534B551801200128095203534B5522460A1552656D6F766550726F64756374526573706F6E7365122D0A0870726F647563747318012003280B32112E73686F702E50726F64756374496E666F520870726F6475637473221E0A1C4C697374417661696C61626C6550726F647563747352657175657374224E0A1D4C697374417661696C61626C6550726F6475637473526573706F6E7365122D0A0870726F647563747318012003280B32112E73686F702E50726F64756374496E666F520870726F647563747322280A1453656172636850726F647563745265717565737412100A03534B551801200128095203534B5522350A1553656172636850726F64756374526573706F6E7365121C0A09617661696C61626C651801200128085209617661696C61626C6522590A11437265617465557365725265717565737412170A07757365725F69641801200128095206757365724964122B0A09757365725F7479706518022001280E320E2E73686F702E55736572547970655208757365725479706522480A1243726561746555736572526573706F6E736512180A077375636365737318012001280852077375636365737312180A076D65737361676518022001280952076D65737361676522AB010A0B50726F64756374496E666F12120A046E616D6518012001280952046E616D6512200A0B6465736372697074696F6E180220012809520B6465736372697074696F6E12140A0570726963651803200128095205707269636512200A0B73746B5175616E74697479180420012805520B73746B5175616E7469747912100A03534B551805200128095203534B55121C0A09617661696C61626C651806200128085209617661696C61626C6522590A10416464546F436172745265717565737412170A07757365725F6964180120012809520675736572496412100A03534B551802200128095203534B55121A0A087175616E7469747918032001280552087175616E7469747922470A11416464546F43617274526573706F6E736512180A077375636365737318012001280852077375636365737312180A076D65737361676518022001280952076D65737361676522450A11506C6163654F726465725265717565737412170A07757365725F6964180120012809520675736572496412170A07636172745F6964180220012809520663617274496422630A12506C6163654F72646572526573706F6E736512180A077375636365737318012001280852077375636365737312190A086F726465725F696418022001280952076F72646572496412180A076D65737361676518032001280952076D6573736167652A230A085573657254797065120C0A08435553544F4D4552100012090A0541444D494E100132D8040A0B53686F705365727669636512400A0B6164645F70726F6475637412172E73686F702E41646450726F64756374526571756573741A182E73686F702E41646450726F64756374526573706F6E736512490A0E7570646174655F70726F64756374121A2E73686F702E55706461746550726F64756374526571756573741A1B2E73686F702E55706461746550726F64756374526573706F6E736512490A0E72656D6F76655F70726F64756374121A2E73686F702E52656D6F766550726F64756374526571756573741A1B2E73686F702E52656D6F766550726F64756374526573706F6E736512620A176C6973745F617661696C61626C655F70726F647563747312222E73686F702E4C697374417661696C61626C6550726F6475637473526571756573741A232E73686F702E4C697374417661696C61626C6550726F6475637473526573706F6E736512490A0E7365617263685F70726F64756374121A2E73686F702E53656172636850726F64756374526571756573741A1B2E73686F702E53656172636850726F64756374526573706F6E7365123C0A09416464546F4361727412162E73686F702E416464546F43617274526571756573741A172E73686F702E416464546F43617274526573706F6E7365123F0A0A506C6163654F7264657212172E73686F702E506C6163654F72646572526571756573741A182E73686F702E506C6163654F72646572526573706F6E736512430A0C6372656174655F757365727312172E73686F702E43726561746555736572526571756573741A182E73686F702E43726561746555736572526573706F6E73652801620670726F746F33";

public isolated client class ShopServiceClient {
    *grpc:AbstractClientEndpoint;

    private final grpc:Client grpcClient;

    public isolated function init(string url, *grpc:ClientConfiguration config) returns grpc:Error? {
        self.grpcClient = check new (url, config);
        check self.grpcClient.initStub(self, SHOP_DESC);
    }

    isolated remote function add_product(AddProductRequest|ContextAddProductRequest req) returns AddProductResponse|grpc:Error {
        map<string|string[]> headers = {};
        AddProductRequest message;
        if req is ContextAddProductRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shop.ShopService/add_product", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <AddProductResponse>result;
    }

    isolated remote function add_productContext(AddProductRequest|ContextAddProductRequest req) returns ContextAddProductResponse|grpc:Error {
        map<string|string[]> headers = {};
        AddProductRequest message;
        if req is ContextAddProductRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shop.ShopService/add_product", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <AddProductResponse>result, headers: respHeaders};
    }

    isolated remote function update_product(UpdateProductRequest|ContextUpdateProductRequest req) returns UpdateProductResponse|grpc:Error {
        map<string|string[]> headers = {};
        UpdateProductRequest message;
        if req is ContextUpdateProductRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shop.ShopService/update_product", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <UpdateProductResponse>result;
    }

    isolated remote function update_productContext(UpdateProductRequest|ContextUpdateProductRequest req) returns ContextUpdateProductResponse|grpc:Error {
        map<string|string[]> headers = {};
        UpdateProductRequest message;
        if req is ContextUpdateProductRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shop.ShopService/update_product", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <UpdateProductResponse>result, headers: respHeaders};
    }

    isolated remote function remove_product(RemoveProductRequest|ContextRemoveProductRequest req) returns RemoveProductResponse|grpc:Error {
        map<string|string[]> headers = {};
        RemoveProductRequest message;
        if req is ContextRemoveProductRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shop.ShopService/remove_product", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <RemoveProductResponse>result;
    }

    isolated remote function remove_productContext(RemoveProductRequest|ContextRemoveProductRequest req) returns ContextRemoveProductResponse|grpc:Error {
        map<string|string[]> headers = {};
        RemoveProductRequest message;
        if req is ContextRemoveProductRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shop.ShopService/remove_product", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <RemoveProductResponse>result, headers: respHeaders};
    }

    isolated remote function list_available_products(ListAvailableProductsRequest|ContextListAvailableProductsRequest req) returns ListAvailableProductsResponse|grpc:Error {
        map<string|string[]> headers = {};
        ListAvailableProductsRequest message;
        if req is ContextListAvailableProductsRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shop.ShopService/list_available_products", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <ListAvailableProductsResponse>result;
    }

    isolated remote function list_available_productsContext(ListAvailableProductsRequest|ContextListAvailableProductsRequest req) returns ContextListAvailableProductsResponse|grpc:Error {
        map<string|string[]> headers = {};
        ListAvailableProductsRequest message;
        if req is ContextListAvailableProductsRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shop.ShopService/list_available_products", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <ListAvailableProductsResponse>result, headers: respHeaders};
    }

    isolated remote function search_product(SearchProductRequest|ContextSearchProductRequest req) returns SearchProductResponse|grpc:Error {
        map<string|string[]> headers = {};
        SearchProductRequest message;
        if req is ContextSearchProductRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shop.ShopService/search_product", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <SearchProductResponse>result;
    }

    isolated remote function search_productContext(SearchProductRequest|ContextSearchProductRequest req) returns ContextSearchProductResponse|grpc:Error {
        map<string|string[]> headers = {};
        SearchProductRequest message;
        if req is ContextSearchProductRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shop.ShopService/search_product", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <SearchProductResponse>result, headers: respHeaders};
    }

    isolated remote function AddToCart(AddToCartRequest|ContextAddToCartRequest req) returns AddToCartResponse|grpc:Error {
        map<string|string[]> headers = {};
        AddToCartRequest message;
        if req is ContextAddToCartRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shop.ShopService/AddToCart", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <AddToCartResponse>result;
    }

    isolated remote function AddToCartContext(AddToCartRequest|ContextAddToCartRequest req) returns ContextAddToCartResponse|grpc:Error {
        map<string|string[]> headers = {};
        AddToCartRequest message;
        if req is ContextAddToCartRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shop.ShopService/AddToCart", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <AddToCartResponse>result, headers: respHeaders};
    }

    isolated remote function PlaceOrder(PlaceOrderRequest|ContextPlaceOrderRequest req) returns PlaceOrderResponse|grpc:Error {
        map<string|string[]> headers = {};
        PlaceOrderRequest message;
        if req is ContextPlaceOrderRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shop.ShopService/PlaceOrder", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <PlaceOrderResponse>result;
    }

    isolated remote function PlaceOrderContext(PlaceOrderRequest|ContextPlaceOrderRequest req) returns ContextPlaceOrderResponse|grpc:Error {
        map<string|string[]> headers = {};
        PlaceOrderRequest message;
        if req is ContextPlaceOrderRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shop.ShopService/PlaceOrder", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <PlaceOrderResponse>result, headers: respHeaders};
    }

    isolated remote function create_users() returns Create_usersStreamingClient|grpc:Error {
        grpc:StreamingClient sClient = check self.grpcClient->executeClientStreaming("shop.ShopService/create_users");
        return new Create_usersStreamingClient(sClient);
    }
}

public client class Create_usersStreamingClient {
    private grpc:StreamingClient sClient;

    isolated function init(grpc:StreamingClient sClient) {
        self.sClient = sClient;
    }

    isolated remote function sendCreateUserRequest(CreateUserRequest message) returns grpc:Error? {
        return self.sClient->send(message);
    }

    isolated remote function sendContextCreateUserRequest(ContextCreateUserRequest message) returns grpc:Error? {
        return self.sClient->send(message);
    }

    isolated remote function receiveCreateUserResponse() returns CreateUserResponse|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, _] = response;
            return <CreateUserResponse>payload;
        }
    }

    isolated remote function receiveContextCreateUserResponse() returns ContextCreateUserResponse|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, headers] = response;
            return {content: <CreateUserResponse>payload, headers: headers};
        }
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.sClient->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.sClient->complete();
    }
}

public client class ShopServicePlaceOrderResponseCaller {
    private grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendPlaceOrderResponse(PlaceOrderResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextPlaceOrderResponse(ContextPlaceOrderResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public client class ShopServiceListAvailableProductsResponseCaller {
    private grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendListAvailableProductsResponse(ListAvailableProductsResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextListAvailableProductsResponse(ContextListAvailableProductsResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public client class ShopServiceAddProductResponseCaller {
    private grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendAddProductResponse(AddProductResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextAddProductResponse(ContextAddProductResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public client class ShopServiceRemoveProductResponseCaller {
    private grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendRemoveProductResponse(RemoveProductResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextRemoveProductResponse(ContextRemoveProductResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public client class ShopServiceSearchProductResponseCaller {
    private grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendSearchProductResponse(SearchProductResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextSearchProductResponse(ContextSearchProductResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public client class ShopServiceCreateUserResponseCaller {
    private grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendCreateUserResponse(CreateUserResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextCreateUserResponse(ContextCreateUserResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public client class ShopServiceUpdateProductResponseCaller {
    private grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendUpdateProductResponse(UpdateProductResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextUpdateProductResponse(ContextUpdateProductResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public client class ShopServiceAddToCartResponseCaller {
    private grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendAddToCartResponse(AddToCartResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextAddToCartResponse(ContextAddToCartResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public type ContextCreateUserRequestStream record {|
    stream<CreateUserRequest, error?> content;
    map<string|string[]> headers;
|};

public type ContextAddProductResponse record {|
    AddProductResponse content;
    map<string|string[]> headers;
|};

public type ContextListAvailableProductsRequest record {|
    ListAvailableProductsRequest content;
    map<string|string[]> headers;
|};

public type ContextListAvailableProductsResponse record {|
    ListAvailableProductsResponse content;
    map<string|string[]> headers;
|};

public type ContextAddToCartResponse record {|
    AddToCartResponse content;
    map<string|string[]> headers;
|};

public type ContextRemoveProductResponse record {|
    RemoveProductResponse content;
    map<string|string[]> headers;
|};

public type ContextAddProductRequest record {|
    AddProductRequest content;
    map<string|string[]> headers;
|};

public type ContextUpdateProductRequest record {|
    UpdateProductRequest content;
    map<string|string[]> headers;
|};

public type ContextSearchProductRequest record {|
    SearchProductRequest content;
    map<string|string[]> headers;
|};

public type ContextAddToCartRequest record {|
    AddToCartRequest content;
    map<string|string[]> headers;
|};

public type ContextPlaceOrderResponse record {|
    PlaceOrderResponse content;
    map<string|string[]> headers;
|};

public type ContextPlaceOrderRequest record {|
    PlaceOrderRequest content;
    map<string|string[]> headers;
|};

public type ContextRemoveProductRequest record {|
    RemoveProductRequest content;
    map<string|string[]> headers;
|};

public type ContextCreateUserResponse record {|
    CreateUserResponse content;
    map<string|string[]> headers;
|};

public type ContextSearchProductResponse record {|
    SearchProductResponse content;
    map<string|string[]> headers;
|};

public type ContextCreateUserRequest record {|
    CreateUserRequest content;
    map<string|string[]> headers;
|};

public type ContextUpdateProductResponse record {|
    UpdateProductResponse content;
    map<string|string[]> headers;
|};

@protobuf:Descriptor {value: SHOP_DESC}
public type ProductInfo record {|
    string name = "";
    string description = "";
    string price = "";
    int stkQuantity = 0;
    string SKU = "";
    boolean available = false;
|};

@protobuf:Descriptor {value: SHOP_DESC}
public type AddProductResponse record {|
    string SKU = "";
|};

@protobuf:Descriptor {value: SHOP_DESC}
public type ListAvailableProductsRequest record {|
|};

@protobuf:Descriptor {value: SHOP_DESC}
public type ListAvailableProductsResponse record {|
    ProductInfo[] products = [];
|};

@protobuf:Descriptor {value: SHOP_DESC}
public type AddToCartResponse record {|
    boolean success = false;
    string message = "";
|};

@protobuf:Descriptor {value: SHOP_DESC}
public type RemoveProductResponse record {|
    ProductInfo[] products = [];
|};

@protobuf:Descriptor {value: SHOP_DESC}
public type AddProductRequest record {|
    string name = "";
    string description = "";
    string price = "";
    int stkQuantity = 0;
    string SKU = "";
|};

@protobuf:Descriptor {value: SHOP_DESC}
public type UpdateProductRequest record {|
    string SKU = "";
    string name = "";
    string description = "";
    string price = "";
    int stkQuantity = 0;
|};

@protobuf:Descriptor {value: SHOP_DESC}
public type SearchProductRequest record {|
    string SKU = "";
|};

@protobuf:Descriptor {value: SHOP_DESC}
public type AddToCartRequest record {|
    string user_id = "";
    string SKU = "";
    int quantity = 0;
|};

@protobuf:Descriptor {value: SHOP_DESC}
public type PlaceOrderResponse record {|
    boolean success = false;
    string order_id = "";
    string message = "";
|};

@protobuf:Descriptor {value: SHOP_DESC}
public type PlaceOrderRequest record {|
    string user_id = "";
    string cart_id = "";
|};

@protobuf:Descriptor {value: SHOP_DESC}
public type RemoveProductRequest record {|
    string SKU = "";
|};

@protobuf:Descriptor {value: SHOP_DESC}
public type CreateUserResponse record {|
    boolean success = false;
    string message = "";
|};

@protobuf:Descriptor {value: SHOP_DESC}
public type SearchProductResponse record {|
    boolean available = false;
|};

@protobuf:Descriptor {value: SHOP_DESC}
public type CreateUserRequest record {|
    string user_id = "";
    UserType user_type = CUSTOMER;
|};

@protobuf:Descriptor {value: SHOP_DESC}
public type UpdateProductResponse record {|
    string message = "";
|};

public enum UserType {
    CUSTOMER, ADMIN
}

