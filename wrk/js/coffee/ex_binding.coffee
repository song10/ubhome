Account = (customer, cart, obj) ->
  @customer = customer
  @cart = cart

  obj.bind 'click', (event) =>
    @customer.purchase @cart

  obj.bind 'dclick', (event) ->
    @customer.purchase @cart

customer1 =
	purchase : (cart) ->
		print "customer #1 purchase #{cart}"
		customer1

customer2 =
	purchase : (cart) ->
		print "customer #2 purchase #{cart}"
		this

obj =
	purchase : (cart) ->
		print "obj.purchase #{cart}"
		customer
	bind : (name, cb) ->
		this[name] = cb
	customer: customer2
	cart: "CART"

acc = new Account customer1, "cart", obj

obj.click "event"
obj.dclick "devent"

acc.cart = "boat"
obj.cart = "BOAT"
obj.click "event"
obj.dclick "devent"
