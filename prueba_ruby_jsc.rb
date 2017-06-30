puts "\nBienvenido al Sistema de Calificaciones de los Alumnos\n"
opcion = 0

while opcion != 4
  puts "\nElija una de las siguientes opciones:\n\n"
  puts "1: Generar archivo con nombres de alumnos y el promedio de sus notas"
  puts "2: Mostrar la cantidad de inasistencias totales"
  puts "3: Mostrar los nombres de los alumnos aprobados"
  puts "4: Salir"
  opcion = gets.chomp.to_i

  case opcion
    when 1
      # Generar archivo con nombres de alumnos y el promedio de sus notas
      file = File.open('notas_alumnos.csv', 'r')
      student_grades = file.readlines.map(&:chomp)
      file.close
      rows_qty = student_grades.length

      rows = []
      rows_arr = []
      students = []
      grades = []
      average = []

      # Splitting student_grades array's rows
      rows_qty.times do |i|
        rows[i] = student_grades[i]
        i += 1
      end

      # Converting rows (String array to Array array) using split
      rows.each_index do |i|
        rows_arr.push(rows[i].split(', '))
      end

      # Saving students names and grades into students and grades arrays 
      rows_arr.each_index do |i|
        students.push(rows_arr[i][0])
        grades[i] = rows_arr[i].drop(1)
      end

      # Converting 'grades' elements from strings to integers using map method
      grades.each_index do |i|
        grades[i] = grades[i].map {|s| s.gsub('A', '0')}
        grades[i] = grades[i].to_a.map(&:to_i)
      end

      # Calculating grade average for each student
      grades.each_index do |i|
        average[i] = (grades[i].inject(0) { |suma, g| suma + g}).to_f/grades[i].length.to_f
      end

      file = File.open('promedio_alumnos.txt', 'w')
      students.each_index do |i|
        file.puts "El promedio de notas de #{students[i]} es de: #{average[i]}\n"
      end
      file.close
      puts "EL ARCHIVO CON PROMEDIO DE NOTAS DE LOS ALUMNOS HA SIDO GENERADO EXITOSAMENTE!!\n"
      
  
    when 2
      # Mostra la cantidad de inasistencias totales
      file = File.open('notas_alumnos.csv', 'r')
      student_grades = file.readlines.map(&:chomp)
      file.close
      rows_qty = student_grades.length

      rows = []
      rows_arr = []
      students = []
      grades = []

      # Splitting student_grades array's rows
      rows_qty.times do |i|
        rows[i] = student_grades[i]
        i += 1
      end

      # Converting 'rows' (String array to Array array) using split
      rows.each_index do |i|
        rows_arr.push(rows[i].split(', '))
      end

      # Saving students names and grades into students and grades arrays 
      rows_arr.each_index do |i|
        students.push(rows_arr[i][0])
        grades[i] = rows_arr[i].drop(1)
      end

      qty_elems = 0
      remaining_elems = 0
      absences = 0
      absences_student = []

      # Counting the absences (A) through all the students grades
      grades.each_index do |i|
        qty_elem = grades[i].length
        remaining_elems = (grades[i] - ['A']).length
        absences_student[i] = (qty_elem - remaining_elems)
        absences += qty_elem - remaining_elems
      end

      puts "\nLA CANTIDAD DE INASISTENCIAS TOTALES DE LOS ALUMNOS FUERON: #{absences}"
      puts "EL DETALLE DE LAS INASISTENCIAS POR ALUMNO ES EL SIGUIENTE: "

      students.each_index do |i|
        print "\n#{students[i]}: #{absences_student[i]}"
      end
      puts "\n"

    when 3
      # Mostrar los nombres de los alumnos aprobados

      print "\nDigite la nota necesaria para que un alumno pueda aprobar: "
      to_pass = gets.chomp.to_i
      print "\n"

      def approved(passing_grade = 5)
        file = File.open('notas_alumnos.csv', 'r')
        student_grades = file.readlines.map(&:chomp)
        file.close
        rows_qty = student_grades.length

        rows = []
        rows_arr = []
        students = []
        grades = []
        average = []

        # Splitting student_grades array's rows
        rows_qty.times do |i|
          rows[i] = student_grades[i]
          i += 1
        end

        # Converting rows (String array to Array array) using split
        rows.each_index do |i|
          rows_arr.push(rows[i].split(', '))
        end

        # Saving students names and grades into students and grades arrays 
        rows_arr.each_index do |i|
          students.push(rows_arr[i][0])
          grades[i] = rows_arr[i].drop(1)
        end

        # Replacing A by 0 and converting 'grades' elements from strings to integers using map method
        grades.each_index do |i|
          grades[i] = grades[i].map {|s| s.gsub('A', '0')}
          grades[i] = grades[i].to_a.map(&:to_i)
        end

        # Calculating grade average for each student
        grades.each_index do |i|
          average[i] = (grades[i].inject(0) { |suma, g| suma + g}).to_f/grades[i].length.to_f
        end

        successful = []
        unsuccessful = []

        students.each_index do |i|
          puts "El promedio de notas de #{students[i]} fue de: #{average[i]}\n"
          if average[i] >= passing_grade
            successful.push(students[i])
          else
            unsuccessful.push(students[i])
          end
        end

        if successful.any?
          print "\nAlumnos aprobados: ", successful
        end
        if unsuccessful.any?
          print "\nAlumnos NO aprobados: ", unsuccessful, "\n"
        end
      end # method end

      approved(to_pass)
    when 4
      puts "HASTA LUEGO!!"

    else
      puts "ELEGISTE UNA OPCIÓN INVÁLIDA! DEBES ELEGIR UN NÚMERO ENTRE 1 Y 4"

  end # case end
end # while end