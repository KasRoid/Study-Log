## Assignments for Week 01 ##

### Assignment 01 : 2020.04.10 ###

**문제에서 요구하는 함수 정의하기**

1. 이름과 나이를 입력 받아 자신을 소개하는 글을 출력하는 함수
   ```Swift
   func intro (name: String, age: Int) {
       print("My name is \(name). I'm \(age) years old")
   }

   intro(name: "Kas", age: 33)
   ```

   Solution
   ```Swift
   func introduceMySelf(withName name: String, age: Int) {
     print("안녕하세요. 제 이름은 \(name)이고 나이는 \(age)살입니다.")
   }

   introduceMySelf(withName: "Tory", age: 5)
   ```

2. 정수를 하나 입력받아 2의 배수 여부를 반환하는 함수
   ```Swift
   func evenOrNot (_ num: Int) {
       if num % 2 == 0 {
           print("2의 배수입니다!")
       }
       else {
           print("2의 배수가 아닙니다!")
       }
   }

   evenOrNot(10)
   evenOrNot(15)
   ```
   Solution
   ```Swift
   func isEven1(number: Int) -> Bool {
     return number % 2 == 0
   }

   func isEven2(number: Int) -> Bool {
     return number.isMultiple(of: 2)
   }

   isEven1(number: 6)
   isEven1(number: 5)
   isEven2(number: 6)
   isEven2(number: 5)
   ```

3. 정수를 두 개 입력 받아 곱한 결과를 반환하는 함수 (파라미터 하나의 기본 값은 10)
   ```Swift
   func multiply (num1: Int = 10, num2: Int) -> Int {
       return num1 * num2
   }

   var a = multiply(num2: 3)
   var b = multiply(num1: 4, num2: 5)
   print(a, b)
   ```
      Solution
   ```Swift
   func multiplyTwoNumbers(op1: Int, op2: Int = 10) -> Int {
     return op1 * op2
   }

   multiplyTwoNumbers(op1: 20, op2: 5)
   multiplyTwoNumbers(op1: 5)
   ```

4. 4과목의 시험 점수를 입력받아 평균 점수를 반환하는 함수
   ```Swift
   func testAverage (test1: Double, test2: Double, test3: Double, test4: Double) -> Double {
       return((test1 + test2 + test3 + test4) / 4)
   }

   var score = testAverage(test1: 10, test2: 5, test3: 8, test4: 7)
   print(score)
   ```
   Solution
   ```Swift
   func averageScore(score1: Double, score2: Double, score3: Double, score4: Double) -> Double {
     let sum = score1 + score2 + score3 + score4
     return sum / 4
   }

   averageScore(score1: 79, score2: 85.5, score3: 90.5, score4: 81)


   func averageScore(scores: Double...) -> Double {
     var sum = 0.0
     for score in scores {
       sum += score
     }
     return sum / Double(scores.count)
   }

   averageScore(scores: 79, 85.5, 90.5, 81)
   ```

5. 점수를 입력받아 학점을 반환하는 함수 만들기 (90점 이상 A, 80점 이상 B, 70점 이상 C, 그 이하 F)
   ```Swift
   func grade (score: Int) -> String {
       if score >= 90 {
           return("A")
       }
       else if score >= 80 {
           return("B")
       }
       else if score >= 70 {
           return("C")
       }
       else {
           return("F")
       }
   }

   print(grade(score: 92))
   print(grade(score: 85))
   print(grade(score: 70))
   print(grade(score: 43))

   ```
      Solution
   ```Swift
   func calculateGrade(from score: Int) -> String {
     let grade: String
     if score >= 90 {
       grade = "A"
     } else if score >= 80 {
       grade = "B"
     } else if score >= 70 {
       grade = "C"
     } else {
       grade = "F"
     }
     return grade
   }

   calculateGrade(from: 100)
   calculateGrade(from: 80)
   calculateGrade(from: 50)
   ```

6. 가변 인자 파라미터를 이용해 점수를 여러 개 입력받아 평균 점수에 대한 학점을 반환하는 함수 (90점 이상 A, 80점 이상 B, 70점 이상 C, 그 이하 F) 
   ```Swift
   func scoreAverage (_ scores: Double...) -> Double {
       var total : Double = 0 // 전체점수를 기록할 변수
       for currentScore in scores { // currentScore 에 score 가 돌아가며 삽입됨)
           total += currentScore
       }
       return (total / Double(scores.count)) // 리턴 단계에서 평균 점수 계산
   }

   var totalScore = scoreAverage(100, 50, 25, 25)
   print(totalScore)

   ```
      Solution
   ```Swift
   func calculateGrade(from scores: Int...) -> String {
     var sum = 0.0
     for score in scores {
       sum += Double(score)
     }
     sum /= Double(scores.count)
     
     if sum >= 90 {
       return "A"
     } else if sum >= 80 {
       return "B"
     } else if sum >= 70 {
       return "C"
     } else {
       return "F"
     }
   }

   calculateGrade(from: 81, 95, 70, 60)
   calculateGrade(from: 92, 84, 70, 99)
   ```