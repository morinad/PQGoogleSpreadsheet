// This file contains your Data Connector logic
section Google;


// Constants
client_id = "733411099704-8hukvljco75ti4nkv25if9314r7edtja.apps.googleusercontent.com";
client_secret = "LXoE9WVFwbkif1L9Y0JN0hOD";
redirect_uri = "https://preview.powerbi.com/views/oauthredirect.html";
windowWidth = 1200;
windowHeight = 1000;


[DataSource.Kind="Google", Publish="Google.UI"]


shared Google.Spreadsheets = (Table_URL as text) =>
    let
        finalUrl = Text.BeforeDelimiter(Table_URL, "/", {0, RelativePosition.FromEnd}) & "/export?format=xlsx",
        content = Web.Contents(finalUrl),
        excel = Excel.Workbook(content, null, true)
    in
        excel;



// Data Source Kind description
Google = [
    TestConnection = (dataSourcePath) => { "Google.Spreadsheets",Json.Document(dataSourcePath)[Table_URL]},
    Authentication = [
        OAuth = [
            StartLogin = StartLogin,
            FinishLogin = FinishLogin,
           // Refresh=Refresh,
	    //Logout = Logout, 
            Label = "Google Spreadsheet Auth"
        ]
    ],
    Label = "Google Spreadsheet Connector"
];


StartLogin = (resourceUrl, state, display) =>
    let
        AuthorizeUrl = "https://accounts.google.com/o/oauth2/v2/auth?" & Uri.BuildQueryString([
            scope = "https://www.googleapis.com/auth/drive.readonly",
            access_type = "offline",
            include_granted_scopes = "true",
            client_id = client_id,
            state = state,
            redirect_uri = redirect_uri,
            prompt="consent",
            response_type = "code"])
    in
        [
            LoginUri = AuthorizeUrl,
            CallbackUri = redirect_uri,
            WindowHeight = windowHeight,
            WindowWidth = windowWidth,
            Context = null
        ];


FinishLogin = (context, callbackUri, state) =>
    let
        Parts = Uri.Parts(callbackUri)[Query]
    in
       TokenMethod("authorization_code","code" ,Parts[code]);



Refresh = (resourceUrl, refresh_token) => TokenMethod("refresh_token", "refresh_token", refresh_token);

Logout = (token) => "https://accounts.google.com/o/oauth2/revoke?token=" & token;



TokenMethod = (grantType,tokenField,code) =>
    let
        string1=[client_id = client_id,
                client_secret = client_secret,
                grant_type = grantType, 
                redirect_uri = redirect_uri],
        string2=Record.AddField(string1,tokenField,code),
        
        Response = Web.Contents("https://www.googleapis.com/oauth2/v4/token", [
            Content = Text.ToBinary(Uri.BuildQueryString(string2)),
            Headers=[#"Content-type" = "application/x-www-form-urlencoded", #"Accept" = "application/json"]]),
        Parts = Json.Document(Response)
    in
        Parts;



Google.UI = [
    Beta = false,
    Category = "Other",
    ButtonText = { "Google Spreadsheet Connector", "Google Spreadsheet Connector Help" },
    LearnMoreUrl = "https://www.youtube.com/channel/UCqSLNYLN_3mf6nA1Xf7fu1g/",
    SourceImage = Google.Icons,
    SourceTypeImage = Google.Icons
];



Google.Icons = [
    Icon16 = { Extension.Contents("GoogleSheets16.png"), Extension.Contents("GoogleSheets20.png"), Extension.Contents("GoogleSheets24.png"), Extension.Contents("GoogleSheets32.png") },
    Icon32 = { Extension.Contents("GoogleSheets32.png"), Extension.Contents("GoogleSheets40.png"), Extension.Contents("GoogleSheets48.png"), Extension.Contents("GoogleSheets64.png") }
];