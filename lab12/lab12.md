## Task 1
### Read Committed
1. In this case both terminals shows different information (in the first terminal we get that fullname of 'jones' is 'Alice Jones' and in the second it is 'ajones'). It is because we edit this information only in the second terminal and haven't committed yet. In case of read committed we have to commit changes to see them in the first terminal.
2. The second terminal hanged until we committed the changes in the first. It was because the second cannot make changes in the field that was changed by first terminal until this changes was not committed. Otherwise there would be "merge conflict".
### Repeatable Read
1. The information in this case is different too. But when we commit changes in the second terminal, nothing changes in the first. It is because the Repeatable read does not update the data until the transaction ends (It has higher isolation level).
2. As we have not committed changes of first terminal, the second one does not know about changes at all, thus it increases the balance by 20.
## Task 2
### Read Committed
The Bob's movement from group 3 to group 2 is hidden for the first transaction(we haven't committed yet), thus when we increase the balance for the people who is in the second group, the balance increases only on Mike's account.
### Repeatable Read
We haven't committed changes of second transaction, thus the first does not know that Bob in the second group. Because of it the first transaction increase the balance only on Mike's account.
## Task 3
### Repeatable Read
The result in the first transaction is the same as in second. It is because we committed changes that we made and, when the second transaction ended its transaction, it pulled changes.
### Serializable
The results are the same as in Repeatable Read.