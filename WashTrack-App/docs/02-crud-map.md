# 1. CRUD Map

| Table           | C | R | U | D | Pages                                               | Who                                       |
|       ---       |---|---|---|---|                   ---                               |               ---                         |
| Customer        | ✓ | ✓ | – | – | Staff Desk – New Laundry Order, Customer Dashboard | System: C, R · Staff: initiates           |
| Staff           | – | – | – | – | Staff Login, Staff Desk                             | Hardcoded login; no Staff table access in login |
| Order_Status    | – | ✓ | – | – | Staff Desk, Customer Dashboard                     | Staff: R · Guest: R own order             |
| Laundry_Order   | ✓ | ✓ | ✓ | – | Staff Desk, Customer Dashboard, History           | Staff: C, R, U · Guest: R own order        |
| Laundry_Item    | ✓ | ✓ | – | – | Staff Desk – New Laundry Order                    | Staff: C, R                                |
| Laundry_Service | – | ✓ | – | – | Staff Desk – Service Dropdown                      | Staff: R                                  |
| Order_Service   | ✓ | ✓ | – | – | Staff Desk – Service Selection                    | Staff: C, R                                |
| Status_History  | ✓ | ✓ | – | – | Staff Desk, Customer Dashboard – Progress Log      | Staff: C, R · Guest: R own order          |
| Payment         | – | – | – | – | Not implemented                                     | Not implemented                           |
| Notification    | ✓ | ✓ | – | – | Customer Dashboard – Notifications                 | System: C · Guest: R own notifications    |
| Claim           | ✓ | – | – | – | Staff Desk – Mark as Claimed                       | System: C                                 |

## Reasons for Unavailable CRUD Actions

Customer: No customer editing or deletion feature.
Staff: No Staff table management or database-based login feature.
Order_Status: Existing statuses are used; no status management feature.
Laundry_Order: Delete is unavailable because order records are retained.
Laundry_Item: No item editing or deletion feature.
Laundry_Service: Services are displayed in a dropdown; no service management feature.
Order_Service: No separate editing or deletion feature.
Status_History: Records are retained and cannot be edited or deleted.
Payment: Payment management is not implemented.
Notification: No notification editing or deletion feature.
Claim: Claim records are automatically created and have no separate viewing, editing, or deletion feature.

## 2. Form Fields for the Two Most Important Tables

### A. Customer Table

| Column Name      | Form Control          | Required? |
|    ---           |        ---            |     ---   |
| Customer_ID      | None (auto-generated) | No        |
| Customer_Name    | Text input            | Yes       |
| Customer_Contact | Telephone input       | Yes       |
| Customer_Email   | Email input           | No        |
| Customer_Address | Text input            | Yes       |

### B. Laundry_Order Table

| Column Name         | Form Control                                | Required?      |
|       ---           |             ---                             |    ---         |
| Order_ID            | None (auto-generated)                       | No             |
| Pickup_Code         | Text input                                  | Yes            |
| Order_Date          | None (automatic timestamp)                  | No             |
| Expected_Claim_Date | Date picker                                 | Yes            |
| Current_Status_ID   | Dropdown from Order_Status                  | Yes            |
| Customer_ID         | Customer looking up from contact number     | Yes            |
| Staff_ID            | Dropdown from Staff                         | Yes            |

## 3. Schema Changes
None.


