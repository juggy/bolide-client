var Bolide = {
	Version: '1.0'
	Url: 'http://localhost:4000/'
};

/*
The server will behave differently for IE. It will not keep the connection open and IE will poll.
For all the other browser, 

*/
Bolide.Client = Class.create({
	
	// Safari need to wait before connecting or else we get a spinner
	//thx macournoyer
	CONNECT_DELAY: 0.5, //sec
	RECONNECT_DELAY: 3, //sec
	
	//statuses
	NOT_CONNECTED = 'NOT_CONNECTED',
	CONNECTED = 'CONNECTED',

	/*
	Callbacks are:
		onConnect : when the client reconnects
		onDisconnect : when the server is unreachable
		onData : when new data is available
	*/
	initialize: function(account, q, token, callbacks){
		
		this.account = account;
		this.q = q;
		this.token = token;
		this.callbacks = callbacks;
		this.status = NOT_CONNECTED
		
		this.url = Bolide.Url + account + '/' + q + '/' + token;
		
		//connect to the server
		this.connect.bind(this).delay(this.CONNECT_DELAY);
	},
	
	connect: function(){
		new Ajax.Request(
			this.url, 
			{ method : 'get',
				onFailure : function(transport){
					if(this.callbacks.onFailure) this.callbacks.onFailure(transport);
					this.connect.bind(this).delay(this.RECONNECT_DELAY);
				},
				onInteractive : function(transport){
					if( this.callbacks.onInteractive ) this.callbacks.onInteractive(transport);
				},
				onSuccess : function(transport){
					if( this.callbacks.onSuccess ) this.callbacks.onSuccess(transport);
					if(Prototype.Browser.IE){
						//reconnect with a delay
						this.connect.bind(this).delay(this.RECONNECT_DELAY);
					}else{
						this.connect.bind(this);
					}
				}
			}
		);	
	}
	
})