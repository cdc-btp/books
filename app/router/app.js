/* global Vue axios */ //> from vue.html
const $ = sel => document.querySelector(sel)
const GET = (url) => axios.get('/api'+url)
const POST = (cmd,data) => axios.post('/api'+cmd,data)

const books = Vue.createApp ({

    data() {
        return {
            list: [],
            book: undefined,
            order: { quantity:1, succeeded:'', failed:'' },
            user: undefined
        }
    },

    methods: {

        search: ({target:{value:v}}) => books.fetch(v && '&$search='+v),

        async fetch (etc='') {
            const {data} = await GET(`/catalog/ListOfBooks?$expand=genre($select=name),currency($select=symbol)${etc}`)
            books.list = data.value
        },

        async inspect (book) {
            books.book = book
            const res = await GET(`/catalog/ListOfBooks/${book.ID}?$select=genre,price,currency&$expand=genre($select=name),currency($select=symbol)`)
            Object.assign (books.book, res.data)
            books.order = { quantity:1 }
            setTimeout (()=> $('form > input').focus(), 111)
        },

        async submitOrder () {
            const {book,order} = books, quantity = parseInt (order.quantity) || 1 // REVISIT: Okra should be less strict
            try {
                const res = await POST(`/catalog/submitOrder`, { quantity, book: book.ID })
                book.stock = res.data.stock
                books.order = { quantity, succeeded: `Successfully ordered ${quantity} item(s).` }
            } catch (e) {
                books.order = { quantity, failed: e.response.data.error ? e.response.data.error.message : e.response.data }
            }
        },

        async login() {
            try {
                const { data:user } = await axios.post('/user-api/login',{})
                if (user.id !== 'anonymous') books.user = user
            } catch (err) { books.user = { id: err.message } }
        },

        async getUserInfo() {
            try {
                const { data:user } = await axios.get('/user-api/currentUser')
                if (user.id !== 'anonymous') books.user = user
            } catch (err) { books.user = { id: err.message } }
        },
    }
}).mount('#app')

books.getUserInfo()
books.fetch() // initially fill list of books

document.addEventListener('keydown', (event) => {
    // hide user info on request
    if (event.key === 'u')  books.user = undefined
})

axios.interceptors.request.use(csrfToken)
function csrfToken (request) {
    if (request.method === 'head' || request.method === 'get') return request
    if ('csrfToken' in document) {
        request.headers['x-csrf-token'] = document.csrfToken
        return request
    }
    return fetchToken().then(token => {
        document.csrfToken = token
        request.headers['x-csrf-token'] = document.csrfToken
        return request
    }).catch(() => {
        document.csrfToken = null // set mark to not try again
        return request
    })

    function fetchToken() {
        return axios.get('/', { headers: { 'x-csrf-token': 'fetch' } })
            .then(res => res.headers['x-csrf-token'])
    }
}