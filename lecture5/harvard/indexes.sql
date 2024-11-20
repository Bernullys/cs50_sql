CREATE INDEX "search_enrollment_by_student_id" ON "enrollments" ("student_id");
CREATE INDEX "search_enrollment_by_courses_id" ON "enrollments" ("course_id");
CREATE INDEX "sort_courses_by_semester" ON "courses" ("semester");
-- THIS NEXT INDEX IS NOT THAT NECESSARY BECAUSE THE QUERY WAS ALREADY FAST
CREATE INDEX "sort_courses_by_department" ON "courses" ("department");
CREATE INDEX "search_satisfies_by_course_id" ON "satisfies" ("course_id");