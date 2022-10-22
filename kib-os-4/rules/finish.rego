package sbercode

allow[msg] {
	res := input
    res.egress == "1"
	msg := "[OK] создан под Egress Gateway"
}

error[msg] {
	res := input
    res.egress != "1"
	msg := "[ERROR] не создан под Egress Gateway"
}

allow[msg] {
	res := input.log
    res.sidecar != "0"
	msg := "[OK] успешный вызов через sidecar proxy"
}

error[msg] {
	res := input.log
    res.sidecar == "0"
	msg := "[ERROR] отсутствует вызов через sidecar proxy"
}

allow[msg] {
	res := input.log
    res.egress != "0"
	msg := "[OK] успешный вызов через egress proxy"
}

error[msg] {
	res := input.log
    res.egress == "0"
	msg := "[ERROR] отсутствует вызов через egress proxy"
}

allow[msg] {
	res := input
    res.gw == "1"
	msg := "[OK] создан Gateway для узла PostgreSQL"
}

error[msg] {
	res := input
    res.gw != "1"
	msg := "[ERROR] не создан Gateway узла PostgreSQL"
}

allow[msg] {
	res := input
    res.vs == "2"
	msg := "[OK] создан Virtual Service для узла PostgreSQL"
}

error[msg] {
	res := input
    res.vs != "2"
	msg := "[ERROR] не создан Virtual Service узла PostgreSQL"
}

allow[msg] {
	res := input
    res.se == "1"
	msg := "[OK] создан Service Entry для узла PostgreSQL"
}

error[msg] {
	res := input
    res.se != "1"
	msg := "[ERROR] не создан Service Entry узла PostgreSQL"
}

error[msg] {
	msg := input.error
}
