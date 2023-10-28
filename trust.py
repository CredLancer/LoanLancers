


def data_collection():
    scores = []
    counter = 1
    loops = 0

    loannum = int(input("How many loans have they taken: "))

    while (loops < loannum):

        
        timing = str(input(f"Was their loan {counter} handed in early, ontime or late: "))

        while (timing.lower() not in ["early" , "ontime" , "late"]):

            print("Please enter a valid response")
            timing = str(input(f"Was their loan {counter} handed in early, ontime or late: "))
        
        if timing.lower() == "early":
            scores.append(102)
            counter += 1
            loops += 1

        elif timing.lower() == "ontime":
            scores.append(100)
            counter += 1
            loops += 1

        else:
            counter += 1
            loops += 1
            late = float(input("Please enter how many days late the loan was: "))

            while late < 0:
                
                print("Please enter a positive number")
                late = float(input("Please enter how many days late the loan was: "))

            if late >= 20.0:
                scores.append(0)

            else:
                late_score = 100 - (5 * late)
                scores.append(late_score)

    return scores


def late_early_points(x):

    late = 0
    early = 0

    for i in x:

        if i > 100:
            early += 1

        elif i < 100:
            late += 1

    late_points = late - early

    if late_points < 0:
        return 0
    
    else:
        return late_points

    

def trust_score_calc(scores, late):
    average = sum(scores) / len(scores)

    trust_score = round(average + (late * -5))
    
    if trust_score < 0:
        trust_score = 0

    elif trust_score > 100:
        trust_score = 100

    return trust_score
    
    


def main():
    
    scores = data_collection()
    time_late = late_early_points(scores)
    trust_score = trust_score_calc(scores, time_late)
    print(f"Your trust score is {trust_score}")

main()
