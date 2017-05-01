# Wat is this

Normally when people go on vacation they might use splitwise.com to settle up
at the end. However, my brother doesn't like use splitwise because they won't let you
sign up with google without letting splitwise have access to your contacts. 

Other times friends have refused to use splitwise because it's "too complicated",
and "can you just figure it out and let me know who to pay", which boiled down
to me using splitwise to enter in all the bills, which is kind of cumbersome.

I figured I'd try to just write a script to do it...

## How to make it work

Enter all the persons in you party and the amounts they payed in the paid.yml
file under people. The payments can either be a single value or an array.

In the paid.yml specify if you want people who are owned money to make payments.
Try this for both true and false if you want, set to false, people who owe money
wont have to make any payments to other people, but you will end up with people
who have to make multiple payments, set to false, you will get equal or less total payments,
put people who are owed money may have to make paymennts.

Then run:

    $ ruby settle_up.rb

## How it works

The algorithm is probably not optimized but it works as follows

1. Sort people based on their balance
2. Have the person who needs to pay the most pay the person who needs to be paid the most, record this payment
3. Update the paid and the payee's balance, remove the person who paid from the group
4. Go back to step 1, repeat until there's no one (or less than 2) people in the group

