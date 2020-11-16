user = User.first_or_create(name: "name", email: "tutor@tutor.com", password:"password", phone_number: "(123)456-7890")

student1 = user.students.find_or_create_by(name: "Hello", phone_number: "(111)111-1111", email: "email@gmail.com")  
student2 = user.students.find_or_create_by(name: "Hi", phone_number: "(222)222-2222", email: "emails@gmail.com") 

tutor1 = Tutor.find_or_create_by(name: "Dmitriy", phone_number: "(347)-761-4403", email: "dmitriy.malayev@gmail.com", years_of_experience: "10")
tutor2 = Tutor.find_or_create_by(name: "Mr. Bean", phone_number: "(000)-010-1101", email: "mrbean@gmail.com", years_of_experience: "100")

10.times do 
    tutor = [tutor1, tutor2].sample  
    start = [1, 2, 3, 4, 5, 6].sample.days.from_now
    tutor.appointments.find_or_create_by(
        student: [student1, student2].sample, 
        subject: ["ruby", "js", "react"].sample, 
        starting_date_and_time: start, 
        ending_date_and_time: start + 1.hour
    )
end 