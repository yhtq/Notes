from typing import Type
import torch
import torch.nn as nn
import torchvision
import torchvision.transforms as transforms


# Device configuration
device = torch.device('cuda' if torch.cuda.is_available() else 'cpu')
if torch.cuda.is_available():
    print('GPU is available')
else:
    print('GPU is not available')
# Hyper-parameters 
input_size = 784
hidden_size = 500
hidden_size2 = 300
num_classes = 10
num_epochs = 5
batch_size = 100
learning_rate = 0.001

# MNIST dataset 
train_dataset = torchvision.datasets.MNIST(root='../../data', 
                                           train=True, 
                                           transform=transforms.ToTensor(),  
                                           download=True)

test_dataset = torchvision.datasets.MNIST(root='../../data', 
                                          train=False, 
                                          transform=transforms.ToTensor())

# Data loader
train_loader = torch.utils.data.DataLoader(dataset=train_dataset, 
                                           batch_size=batch_size, 
                                           shuffle=True)

test_loader = torch.utils.data.DataLoader(dataset=test_dataset, 
                                          batch_size=batch_size, 
                                          shuffle=False)

# Fully connected neural network with one hidden layer
class NeuralNet(nn.Module):
    def __init__(self, input_size, hidden_size, num_classes):
        super(NeuralNet, self).__init__()
        self.fc1 = nn.Linear(input_size, hidden_size) 
        self.relu = nn.ReLU()
        self.fc2 = nn.Linear(hidden_size, hidden_size2)
        self.relu2 = nn.ReLU()
        self.fc3 = nn.Linear(hidden_size2, num_classes)
    
    def forward(self, x):
        out = self.fc1(x)
        out = self.relu(out)
        out = self.fc2(out)
        out = self.relu2(out)
        out = self.fc3(out)
        return out

class MySGD(torch.optim.Optimizer):
    def __init__(self, params, lr=0.01):
        defaults = dict(lr=lr)
        super(MySGD, self).__init__(params, defaults)

    def step(self, closure=None):
        for group in self.param_groups:
            for p in group['params']:
                if p.grad is None:
                    continue
                d_p = p.grad
                p.data.add_(-group['lr'], d_p)
    
    def print_info(self) -> str:
        return f"SGD with lr={self.param_groups[0]['lr']}"

class MySGD_WithHeavyBall(torch.optim.Optimizer):
    def __init__(self, params, lr=0.01, momentum_factor=0.9):
        defaults = dict(lr=lr, momentum_factor=momentum_factor)
        super(MySGD_WithHeavyBall, self).__init__(params, defaults)
        for group in self.param_groups:
            for p in group['params']:
                self.state[p]['v'] = torch.zeros_like(p.data)

    def step(self, closure=None):
        for group in self.param_groups:
            for p in group['params']:
                if p.grad is None:
                    continue
                d_p = p.grad
                # v_(t + 1) = beta v_t - grad
                # x_(t + 1) = x_t + lr v_(t + 1)
                v = self.state[p]['v']
                v.mul_(group['momentum_factor']).sub_(d_p)
                p.data.add_(group['lr'], v)
    
    def print_info(self) -> str:
        return f"SGD with Heavy Ball with lr={self.param_groups[0]['lr']}, momentum_factor={self.param_groups[0]['momentum_factor']}"

class MySGD_WithNesterov(torch.optim.Optimizer):
    def __init__(self, params, lr=0.01, momentum_factor=0.9):
        defaults = dict(lr=lr, momentum_factor=momentum_factor)
        super(MySGD_WithNesterov, self).__init__(params, defaults)
        self.t = 0
        for group in self.param_groups:
            for p in group['params']:
                self.state[p]['x'] = torch.zeros_like(p.data)

    def step(self, closure=None):
        beta_t: float = (self.t - 1) / (self.t + 2)
        self.t += 1
        for group in self.param_groups:
            for p in group['params']:
                if p.grad is None:
                    continue
                d_p = p.grad
                # x_(t + 1) = p_t - eta grad
                # p_(t + 1) = x_(t + 1) + beta_t (x_(t + 1) - x_t)
                x_t = self.state[p]['x']
                x_t1 = p.data.sub(d_p, alpha = group['lr'])
                p.data = x_t1.add(x_t1.sub(x_t), alpha = beta_t)
                x_t.copy_(x_t1)
    
    def print_info(self) -> str:
        return f"SGD with Nesterov with lr={self.param_groups[0]['lr']}, momentum_factor={self.param_groups[0]['momentum_factor']}"

class MyAdam(torch.optim.Optimizer):
    def __init__(self, params, lr=0.01, beta_1=0.9, beta_2=0.999, epsilon=1e-8):
        defaults = dict(lr=lr, beta_1=beta_1, beta_2=beta_2, epsilon=epsilon)
        super(MyAdam, self).__init__(params, defaults)
        self.t = 0
        for group in self.param_groups:
            for p in group['params']:
                self.state[p]['m'] = torch.zeros_like(p.data)
                self.state[p]['v'] = torch.zeros_like(p.data)

    def step(self, closure=None):
        self.t += 1
        for group in self.param_groups:
            for p in group['params']:
                if p.grad is None:
                    continue
                d_p = p.grad
                m_t = self.state[p]['m']
                v_t = self.state[p]['v']
                m_t.mul_(group['beta_1']).add_(d_p, alpha = 1 - group['beta_1'])
                v_t.mul_(group['beta_2']).addcmul_(d_p, d_p, value = 1 - group['beta_2'])
                m_hat = m_t / (1 - group['beta_1'] ** self.t)
                v_hat = v_t / (1 - group['beta_2'] ** self.t)
                
                p.data.sub_(m_hat / (v_hat.sqrt() + group['epsilon']), alpha = group['lr'])
    
    def print_info(self) -> str:
        return f"Adam with lr={self.param_groups[0]['lr']}, beta_1={self.param_groups[0]['beta_1']}, beta_2={self.param_groups[0]['beta_2']}, epsilon={self.param_groups[0]['epsilon']}"
        
def train_opt(opt: Type[torch.optim.Optimizer], lr: float) -> None:
    model = NeuralNet(input_size, hidden_size, num_classes).to(device)
    # Loss and optimizer
    criterion = nn.CrossEntropyLoss()
    # optimizer = torch.optim.Adam(model.parameters(), lr=learning_rate)  
    optimizer = opt(model.parameters(), lr=lr)
    print(optimizer.print_info())

    # Train the model
    total_step = len(train_loader)
    for epoch in range(num_epochs):
        for i, (images, labels) in enumerate(train_loader):  
            # Move tensors to the configured device
            images = images.reshape(-1, 28*28).to(device)
            labels = labels.to(device)
            
            # Forward pass
            outputs = model(images)
            loss = criterion(outputs, labels)
            
            # Backward and optimize
            optimizer.zero_grad()
            loss.backward()
            optimizer.step()
            
            if (i+1) % 100 == 0:
                print ('Epoch [{}/{}], Step [{}/{}], Loss: {:.4f}' 
                    .format(epoch+1, num_epochs, i+1, total_step, loss.item()))

    # Test the model
    # In test phase, we don't need to compute gradients (for memory efficiency)
    with torch.no_grad():
        correct = 0
        total = 0
        for images, labels in test_loader:
            images = images.reshape(-1, 28*28).to(device)
            labels = labels.to(device)
            outputs = model(images)
            _, predicted = torch.max(outputs.data, 1)
            total += labels.size(0)
            correct += (predicted == labels).sum().item()

        print('Accuracy of the network on the 10000 test images: {} %'.format(100 * correct / total))

    # Save the model checkpoint
    torch.save(model.state_dict(), f'{optimizer.print_info()}.ckpt')

train_opt(MySGD, 0.05)
train_opt(MySGD_WithHeavyBall, 0.03)
train_opt(MySGD_WithNesterov, 0.01)
train_opt(MyAdam, 0.001)