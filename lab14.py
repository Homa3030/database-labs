import redis
r = redis.Redis(
    host='redis-17260.c261.us-east-1-4.ec2.cloud.redislabs.com',
    port="17260",
    password='M8hRI3uOwqkYa6MrepTAesyGVwC0ZobC')
print(r)
customers = []
orders = []
customers.append({"customer_numb": '001', "first_name": 'Jane', "last_name": 'Doe'})
customers.append({"customer_numb": '002', "first_name": 'John', "last_name": 'Doe'})
customers.append({"customer_numb": '003', "first_name": 'Jane', "last_name": 'Smith'})
customers.append({"customer_numb": '005', "first_name": 'Jane', "last_name": 'Jones'})
customers.append({"customer_numb": '006', "first_name": 'John', "last_name": 'Jones'})

orders.append({"order_number": '1001', "customer_numb": '002', "order_date": '10/10/09', "order_total": '250.85'})
orders.append({"order_number": '1002', "customer_numb": '002', "order_date": '2/21/10', "order_total": '125.89'})
orders.append({"order_number": '1003', "customer_numb": '003', "order_date": '11/15/09', "order_total": '1567.99'})
orders.append({"order_number": '1004', "customer_numb": '004', "order_date": '11/22/09', "order_total": '180.92'})
orders.append({"order_number": '1005', "customer_numb": '004', "order_date": '12/15/09', "order_total": '565.00'})
orders.append({"order_number": '1006', "customer_numb": '006', "order_date": '11/22/09', "order_total": '25.00'})
orders.append({"order_number": '1007', "customer_numb": '006', "order_date": '10/8/09', "order_total": '85.00'})
orders.append({"order_number": '1008', "customer_numb": '006', "order_date": '12/29/09', "order_total": '109.12'})


with r.pipeline() as pipe:
    for i in range(len(customers)):
        pipe.hmset('customer' + str(i), customers[i])
    pipe.execute()

for i in range(len(customers)):
    print(r.hgetall('customer' + str(i)))

with r.pipeline() as pipe:
    for i in range(len(orders)):
        pipe.hmset('order' + str(i), orders[i])
    pipe.execute()

for i in range(len(orders)):
    print(r.hgetall('order' + str(i)))


profile = []
profile.append({"username":'', "id":'', "followers":[],"following":[],"posts":[{"info":'', "time":''}]})

post = []
post.append({"info":'', "time":''})

pipe.hmset('profile' + str(i), profile[0])
print(r.hgetall('profile' + str(i)))

pipe.hmset('post' + str(i), post[0])
print(r.hgetall('post' + str(i)))