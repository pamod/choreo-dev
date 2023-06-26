import Container from 'react-bootstrap/Container';
import Nav from 'react-bootstrap/Nav';
import Navbar from 'react-bootstrap/Navbar';
import { Link } from 'react-router-dom';
import { useAuthContext } from "@asgardeo/auth-react";
import { useState } from 'react';

const logout = signOut => {
    localStorage.removeItem('authenticated');
    localStorage.removeItem('userName');
    localStorage.removeItem('decodedId');
    localStorage.removeItem('group');
    signOut();
};

const LoginStatusBar = props => {
    const { state, signIn, signOut, getDecodedIDToken, getAccessToken } = useAuthContext();
    let authenticated = localStorage.getItem('authenticated');

    const decodedToken = async () => {
        if (state.isAuthenticated === true) {
            let token = await getDecodedIDToken();
            localStorage.setItem('decodedId', JSON.stringify(token));
            localStorage.setItem('group', token?.groups?.[0]);
            props.setDecodedGroup(token?.groups?.[0]);
        }
    };

    const accessToken = async () => {
        if (state.isAuthenticated === true) {
            let token = await getAccessToken();
            localStorage.setItem('accessToken', token);
        }
    };

    if (authenticated != null || state.isAuthenticated === true) {
        if (authenticated == null) {
            localStorage.setItem('authenticated', true);
            localStorage.setItem('userName', state.username);
            decodedToken();
            accessToken();
        }
        return (
            <div>
                <Navbar.Text>
                    {localStorage.getItem('userName')}
                </Navbar.Text>
                <Nav.Link onClick={() => logout(signOut)}>Logout</Nav.Link>
            </div>
        );
    } else {
        return <Nav.Link onClick={() => signIn()}>Login</Nav.Link>
    }
}

const Navigation = () => {
    const [decodedGroup, setDecodedGroup] = useState('');
    let group = localStorage.getItem('group');

    return (
        <Navbar bg="light" expand="lg">
            <Container>
                <Navbar.Brand href="#home">Banking Loyalty Platform</Navbar.Brand>
                <Navbar.Toggle aria-controls="basic-navbar-nav" />
                <Navbar.Collapse id="basic-navbar-nav">
                    <Nav className="me-auto">
                        <Nav.Link as={Link} to="/">Home</Nav.Link>
                        { group === 'Manager' && <Nav.Link as={Link} to="/manage">Manage</Nav.Link>}
                        { group === 'User' && <Nav.Link as={Link} to="/points">MyPoints</Nav.Link >}
                    </Nav>
                </Navbar.Collapse>
                <Navbar.Collapse className="justify-content-end">
                    <LoginStatusBar setDecodedGroup={setDecodedGroup} />
                </Navbar.Collapse>
            </Container>
        </Navbar>
    );
}

export default Navigation;