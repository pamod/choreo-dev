import ballerinax/mysql;
import ballerinax/mysql.driver as _;
import ballerina/sql;
import ballerina/io;
import ballerina/http;

# A service representing a network-accessible API
# bound to port `9090`.
service /catalog on new http:Listener(9090) {
    // init service
    function init() returns error? {
        sql:Error? catalogTable = createCatalogTable();
        if catalogTable is sql:Error {
            io:println("Error occured while creating table", catalogTable);
        }
        if catalogTable is error {
            io:println("Error occured while creating table", catalogTable);
        }
    }

    function stop() {
        completeDatabaseOperations();
    }

    // resource function to add catalog
    resource function post addCatalog(@http:Payload Catalog catalog) returns json {
        sql:Error? result = insertCatalog(catalog);
        if result is sql:Error {
            io:println("Error occured while inserting data", result);
        }
        if result is error {
            io:println("Error occured while inserting data", result);
        }
        return {"message": "Operation Successful"};
    }

    // resource function to update catalog  
    resource function put updateCatalog(@http:Payload Catalog catalog) returns json {
        sql:Error? result = updateCatalog(catalog);
        if result is sql:Error {
            io:println("Error occured while updating data", result);
        }
        if result is error {
            io:println("Error occured while updating data", result);
        }
        return {"message": "Operation Successful"};
    }

    // resource function to delete catalog
    resource function delete [string title]() returns json {
        sql:Error? result = deleteCatalog(title);
        if result is sql:Error {
            io:println("Error occured while deleting data", result);
        }
        if result is error {
            io:println("Error occured while deleting data", result);
        }
        return {"message": "Operation Successful"};
    }

    // resource function to get all catalog 
    resource function get getCatalog() returns json {
        Catalog[]?|error result = getCatalog();
        if result is Catalog[] {
            return result.toJson();
        } else {
            return {"message": "Operation Failed"};
        }
    }
}

type Catalog record {
    string Title;
    string Description;
    string Includes;
    string IntendedFor;
    string Color;
    string Matirial;
    decimal Price;
};

mysql:Options DBOptions = {
    ssl: {
        mode: mysql:SSL_REQUIRED
    }
};

final mysql:Client dbClient = check new (host = "sahackathon.mysql.database.azure.com", user = "choreo", password = "wso2!234",
port = 3306, database = "pamod_db", options = DBOptions, connectionPool = {maxOpenConnections: 5});

function completeDatabaseOperations() {
    sql:Error? close = dbClient.close();
    if (close is error) {
        io:println("Error occured while closing database client", close);
    }
}

// create function to insert catalog 
function insertCatalog(Catalog catalog) returns sql:Error? {
    sql:ParameterizedQuery query = `INSERT INTO petstore (Title, Description, Includes, IntendedFor, Color, Matirial, Price) 
    VALUES (${catalog.Title}, ${catalog.Description}, ${catalog.Includes}, ${catalog.IntendedFor}, ${catalog.Color}, ${catalog.Matirial}, ${catalog.Price})`;
    sql:ExecutionResult|sql:Error result = dbClient->execute(query);
    if (result is sql:ExecutionResult) {
        io:println("Query executed successfully");
    } else {
        io:println("Error occured while executing query");
    }
}

// create function to update catalog 
function updateCatalog(Catalog catalog) returns sql:Error? {
    sql:ParameterizedQuery query = `UPDATE petstore SET Title = ${catalog.Title}, Description = ${catalog.Description}, Includes = ${catalog.Includes}, IntendedFor = ${catalog.IntendedFor}, Color = ${catalog.Color}, Matirial = ${catalog.Matirial}, Price = ${catalog.Price} WHERE Title = ${catalog.Title}`;
    sql:ExecutionResult|sql:Error result = dbClient->execute(query);
    if (result is sql:ExecutionResult) {
        io:println("Query executed successfully");
    } else {
        io:println("Error occured while executing query");
    }
}

// create function to delete catalog 
function deleteCatalog(string title) returns sql:Error? {
    sql:ParameterizedQuery query = `DELETE FROM petstore WHERE Title = ${title}`;
    sql:ExecutionResult|sql:Error result = dbClient->execute(query);
    if (result is sql:ExecutionResult) {
        io:println("Query executed successfully");
    } else {
        io:println("Error occured while executing query");
    }
}

// create function to gat catalog records
function getCatalog() returns error|Catalog[] {
    Catalog[] catalogs = [];
    sql:ParameterizedQuery query = `SELECT * FROM petstore`;
    stream<Catalog, sql:Error?> result = dbClient->query(query);
    error? e = result.forEach(function(Catalog catalog) {
        catalogs.push(catalog);
    });
    if (e is error) {
        return e;
    } else {
        return catalogs;
    }
}

// create function to get catalog record by title
function getCatalogByTitle(string title) returns error|Catalog? {
    Catalog? catValue = ();
    sql:ParameterizedQuery query = `SELECT * FROM petstore WHERE Title = ${title} LIMIT 1`;
    stream<Catalog, sql:Error?> result = dbClient->query(query);
    error? e = result.forEach(function(Catalog catalog) {
        catValue = catalog;
    });
    if (e is error) {
        return e;
    } else {
        return catValue;
    }
}

// Create function to execute SQL query
function createCatalogTable() returns sql:Error? {
    sql:ExecutionResult|sql:Error result = dbClient->execute(`CREATE TABLE IF NOT EXISTS petstore (
    Title varchar(255), 
    Description varchar(255), 
    Includes varchar(255), 
    IntendedFor varchar(255), 
    Color varchar(255), 
    Matirial varchar(255), 
    Price DECIMAL)`);
    if (result is sql:ExecutionResult) {
        io:println("Query executed successfully");
    } else {
        io:println("Error occured while executing query");
    }
}

