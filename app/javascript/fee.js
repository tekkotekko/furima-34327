function fee(){
  const price=document.getElementById("item-price");
  const fee=document.getElementById("add-tax-price");
  const profit=document.getElementById("profit");
  price.addEventListener("keyup", function(){
    const priceValue=price.value;
    const feeValue=Math.floor(priceValue*0.1);
    const profitValue=priceValue - feeValue;
    const formatter=new Intl.NumberFormat("ja")
    fee.innerHTML=formatter.format(feeValue);
    profit.innerHTML=formatter.format(profitValue);
  })
}

window.addEventListener("load", fee)