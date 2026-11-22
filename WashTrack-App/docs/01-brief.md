# Project Brief: [App name]

## 1. The problem
Who has the problem, and what is hard for them today? (2-3 sentences)

Laundry shop staff need an organized way to manage customer information, laundry orders, services, and payments. Manual record-keeping can make it difficult to track orders and monitor their progress. WashTrack helps organize laundry shop operations in one system.

## 2. Users and what they need to do

| User role | What they need to do in the app |
|-----------|---------------------------------|
| Staff     | Add customers, create laundry orders, update order status, and record payments.     |
| Customer  | Search and check laundry order status using a pickup code. |

## 3. The database behind it
Database name, number of tables, and one sentence per table.

Database name: laundry_management

Number of tables: 11

1. Customer - Stores customer information and contact details.

2. Staff - Stores staff information and account details.

3. Laundry_Service - Stores available laundry services and prices.

4. Order_Status - Stores the available order statuses.

5. Laundry_Order - Stores laundry order information.

6. Laundry_Item - Stores the items included in each order.

7. Order_Service - Connects laundry orders with their selected services.

8. Status_History - Records changes in order status.

9. Payment - Stores payment information.

10. Notification - Stores customer notifications.

11. Claim - Records completed laundry order claims.

## 4. Must-have features (for the final project)
List 4-6. Each one should start with a verb: "Add...", "Search...", "Approve..."

1. Add customer records using the Customer table.

2. Create laundry orders using the Laundry_Order table.

3. Add laundry items using the Laundry_Item table.

4. Select laundry services using the Order_Service table.

5. Update order progress using the Order_Status and Status_History tables.

6. Record customer payments using the Payment table.

## 5. Nice-to-have features (only if there's time)
List 1-3.

1. Send notifications about order updates.

2. Generate daily and monthly sales reports.

3. View previous laundry orders.

## 6. Similar apps I looked at
Name 1-2 real websites or apps and one idea you'll borrow from each.

1. Laundryheap - Borrow its online laundry booking and order-tracking features.

2. CleanCloud - Borrow its organized customer and laundry order management features.