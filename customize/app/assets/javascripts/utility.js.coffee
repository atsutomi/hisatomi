$(document).ready ->
    changelunchbox()
    changenum()
    chnagedate()
    cal()
    return
    

cal = ->
    selected = document.getElementById("order_lunchbox_id")
    lbox_id = selected.options.selectedIndex
    rate = 1.5 if lbox_id is 0
    rate = 1.0 if lbox_id is 1
    rate = 0.5 if lbox_id is 2
    
    div_price = document.getElementById("price")
    price = div_price.getAttribute('data-price')
    cal_price = price * rate
    p_price = document.createTextNode("#{cal_price}円")
    div_price.removeChild(div_price.childNodes.item(0)); 
    div_price.appendChild(p_price)
        
    div_kcal = document.getElementById("kcal")
    kcal = div_kcal.getAttribute('data-kcal')
    cal_kcal = kcal *rate
    p_kcal = document.createTextNode("#{cal_kcal}kcal")
    div_kcal.removeChild(div_kcal.childNodes.item(0)); 
    div_kcal.appendChild(p_kcal)
    
    num = document.getElementById("order_num").value
    div_status = document.getElementById("status")
    if div_status.hasChildNodes()
        div_status.removeChild(div_status.childNodes[0]);
    status = div_status.getAttribute('data-status')
    amount = rate * num
    red = status - amount
    if red <= 50
        p_status = document.createTextNode("この日の在庫が少ないため、この予約は仮予約とさせていただきます。")
        div_status.appendChild(p_status)
    else if div_status.hasChildNodes()
        div_status.remoceChild(div_status.childNodes[0]);
    alert(status)
    alert(red)
    return

reload = ->
    btn = document.getElementsByName("changedate")
    btn[0].click()
    return

changelunchbox = ->
    selected = document.getElementById("order_lunchbox_id")
    selected.addEventListener('change',cal,false)
    return

changenum = ->
    num = document.getElementById("order_num")
    num.addEventListener('change',cal,false)
    return

chnagedate = ->
    year = document.getElementById("order_receive_date_1i")
    month = document.getElementById("order_receive_date_2i")
    date = document.getElementById("order_receive_date_3i")
    year.addEventListener('change', reload, false)
    month.addEventListener('change', reload, false)
    date.addEventListener('change', reload, false)
    