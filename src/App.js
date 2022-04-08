import logo from './logo.svg';
import './App.css';
import axios from 'axios';

function App() {
    var segment_str = window.location.pathname;
    var segment_array = segment_str.split('/');
    var HospitalID = segment_array.pop();

    axios.get(`https://bk2-7k5qcren2q-el.a.run.app/hospital/getSelectedHospitals`, {
        params: {
            HID: HospitalID
        }
    })
        .then((response) => {
            window.location.href = 'https://qreasy.s3.ap-south-1.amazonaws.com/QR-UI/index.html?HID=' + HospitalID;
        })
    return (
        <div className="App">

        </div>
    );
}

export default App;
