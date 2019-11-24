;;;;;;;;;;;;;;;;;;;
/* DEFTEMPLATE */
;;;;;;;;;;;;;;;;;;;

(deftemplate shape
   (slot base_shape)
   (slot type_shape))

;;;;;;;;;;;;;;;;;;;
/* DEFFACTS      */
;;;;;;;;;;;;;;;;;;;

;;****************
;;* DEFFUNCTIONS *
;;****************

;;;;;;;;;;;;;;;;;;;
/* DEFRULE */
;;;;;;;;;;;;;;;;;;;

(defrule startup
	=>
	(printout t "Welcome to shape detector!" crlf)
)

/* ----------- SEGITIGA -----------*/

(defrule isTriangle
	(totalPoint 3)
   =>
	(assert(segitiga yes))
)

(defrule isTriangleLancip
	(segitiga yes)
   (point ?n ?x ?y ?angle)
   (not(> ?angle 90))
   (neq ?angle 90)
   =>
	(assert(segitigaLancip yes))
)

(defrule isTriangleTumpul
	(segitiga yes)
   (point ?n ?x ?y ?angle)
   (> ?angle 90)
   =>
	(assert(segitigaTumpul yes))
)

(defrule isTriangleSiku
	(segitiga yes)
   (point ?n ?x ?y 90)
   =>
	(assert(segitigaSiku yes))
)

(defrule isTriangleKaki
	(segitiga yes)
   (point 1 ?x ?y ?angle1)
   (point 2 ?x ?y ?angle2)
   (point 3 ?x ?y ?angle3)
   (or (eq ?angle1 ?angle2) (eq ?angle1 ?angle3) (eq ?angle3 ?angle2))
   (neq ?angle1 60)
   (neq ?angle2 60)
   (neq ?angle3 60)
   =>
	(assert(segitigaSamaKaki yes))
)

(defrule isTriangleSisi
	(segitiga yes)
   (point 1 ?x ?y ?angle1)
   (point 2 ?x ?y ?angle2)
   (point 3 ?x ?y ?angle3)
   (neq angle1 60)
   (neq angle2 60)
   (neq angle3 60)
   =>
	(assert(segitigaSamaSisi yes))
)

(defrule isTriangleKakiLancip
	(segitigaSamaKaki yes)
   (segitigaLancip yes)
   =>
	(assert(segitigaKakiLancip yes))
)

(defrule isTriangleKakiTumpul
	(segitigaSamaKaki yes)
   (segitigaTumpul yes)
   =>
	(assert(segitigaKakiTumpul))
)

(defrule isTriangleKakiSiku
   (segitigaSamaKaki yes)
	(segitigaSiku yes)
   =>
	(assert(segitigaKakiSiku yes))
)

/* ----------- SEGIEMPAT -----------*/

(defrule isRectangle
	(totalPoint 4)
   =>
	(assert(segiempat yes))
)

(defrule isRectangleGenjang
   (segiempat yes)
   (line ?l1 ?p1) (line ?l2 ?p2) (eq ?p1 ?p2)
   (line ?l3 ?p3) (line ?l4 ?p4) (eq ?p3 ?p4)
   (neq ?l1 ?l2 ?l3 ?l4)
   =>
   (assert(segiempatGenjang yes))
)

(defrule segiempatBeraturan
   (segiempatGenjang yes)
   (line 1 ?p1)
   (line 2 ?p2)
   (line 3 ?p3)
   (line 4 ?p4)
   (eq ?p1 ?p2 ?p3 ?p4)
   =>
   (assert(segiempatBeraturan yes))
)

(defrule segiempatLayang
   (segiempatBeraturan yes)
   (line ?l1 ?p1)
   (line ?l2 ?p2)
   (point ?po1 ?x1 ?y1 90)
   (eq ?p1 ?p2)
   (or (eq ?l1+1 ?l2) (eq ?l3+1 ?l4))
   (or (eq ?l1 ?po1+1) (eq ?l1 ?po1-1) (eq ?l1 4) (eq ?po1 1))
   =>
   (assert(segiempatLayang yes))
)

(defrule trapesium
   (segiempat yes)
   =>
   (assert(trapesium yes))
)

(defrule trapesiumKaki
   (trapesium yes)
   (point ?p1 ?x1 ?y1 ?angle1)
   (point ?p2 ?x2 ?y2 ?angle2)
   (eq ?angle1 ?angle2)
   =>
   (assert(trapesiumKaki yes))
)

(defrule trapesiumKanan
   (trapesium yes)
   (point ?p1 ?x1 ?y1 90)
   (point ?p2 ?x2 ?y2 90)
   (point ?p3 ?x3 ?y3 ?angle)
   (neq ?p1 ?p2 ?p3)
   (> ?x1 ?x3)
   =>
   (assert(trapesiumKanan yes))
)

(defrule trapesiumKiri
   (point ?p1 ?x1 ?y1 90)
   (point ?p2 ?x2 ?y2 90)
   (point ?p3 ?x3 ?y3 ?angle)
   (neq ?p1 ?p2 ?p3)
   (< ?x1 ?x3)
   =>
   (assert(trapesiumKiri yes))
)

/*---------- SEGILIMA ----------*/

(defrule segiLima
   (totalPoint 5)
   =>
   (assert(segiLima yes))
)

(defrule segiLimaSisi
   (line 1 ?p1)
   (line 2 ?p2)
   (line 3 ?p3)
   (line 4 ?p4)
   (line 5 ?p5)
   (eq ?p1 ?p2 ?p3 ?p4 ?p5)
   =>
   (assert(segiLimaSisi yes))
)

/*---------- SEGIENAM ----------*/

(defrule segiEnam
   (totalPoint 6)
   =>
   (assert(segiEnam yes))
)

(defrule segiEnamSisi
   (line 1 ?p1)
   (line 2 ?p2)
   (line 3 ?p3)
   (line 4 ?p4)
   (line 5 ?p5)
   (line 6 ?p6)
   (eq ?p1 ?p2 ?p3 ?p4 ?p5 ?p6)
   =>
   (assert(segiEnamSisi yes))
)