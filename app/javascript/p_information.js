function post() {
  const pInfoSelect = document.getElementById("pInformationSelect");

  pInfoSelect.addEventListener("change", function () {
    const pInfoId = pInfoSelect.value;
    const XHR = new XMLHttpRequest();
    XHR.open("GET", `/p_informations/${pInfoId}`, true);
    XHR.responseType = "json";
    XHR.send();
    XHR.onload = () => {
      // レスポンスに何かしら問題があった時の条件分岐
      if (XHR.status != 200) {
        alert(`Error ${XHR.status}: ${XHR.statusText}`);
        return null;
      }
      const responseData = XHR.response; // レスポンスデータを取得
      // フォームの各フィールドにデータを設定
      const pNameField = document.querySelector("input[name='stock[p_name]']"); 
      const categoryField = document.getElementById("dropdown1");
      const amountField = document.querySelector("input[name='stock[amount]']");
      const standardField = document.getElementById("dropdown2");

      pNameField.value = responseData.p_name;
      categoryField.value = responseData.category_id;
      amountField.value = responseData.amount;
      standardField.value = responseData.standard_id;

      console.log(responseData);
    };
  });
}

// ページが読み込まれた後にpost関数を呼び出す
document.addEventListener("DOMContentLoaded", post);